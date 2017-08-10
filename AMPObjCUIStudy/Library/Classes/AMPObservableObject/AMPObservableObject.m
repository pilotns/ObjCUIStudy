//
//  AMPObservableObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

#import "AMPMacro.h"

@interface AMPObservableObject ()
@property (nonatomic, retain)   NSHashTable     *mutableListeners;
@property (nonatomic, assign)   BOOL            postNotifications;

- (void)notifyOfStateWithSelector:(SEL)aSelector userInfo:(id)userInfo;

- (void)performBlock:(void (^)(void))block postNotifications:(BOOL)yesOrNo;

@end

@implementation AMPObservableObject

@synthesize state = _state;

@dynamic listeners;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.mutableListeners = [NSHashTable weakObjectsHashTable];
    self.postNotifications = YES;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (id)target {
    return self;
}

- (NSSet *)listeners {
    @synchronized (self) {
        return [self.mutableListeners setRepresentation];
    }
}

- (NSUInteger)state {
    @synchronized (self) {
        return _state;
    }
}

- (void)setState:(NSUInteger)state {
    [self setState:state userInfo:nil];
}

- (void)setState:(NSUInteger)state userInfo:(id)userInfo {
    @synchronized (self) {
        if (_state != state) {
            _state = state;
        }
        
        [self notifyOfStateWithSelector:[self selectorForState:state] userInfo:userInfo];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addListener:(id)listener {
    @synchronized (self) {
        [self.mutableListeners addObject:listener];
    }
}

- (void)removeListener:(id)listener {
    @synchronized (self) {
        [self.mutableListeners removeObject:listener];
    }
}

- (BOOL)isListener:(id)listener {
    @synchronized (self) {
        return [self.mutableListeners containsObject:listener];
    }
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfState:state userInfo:nil];
}

- (void)notifyOfState:(NSUInteger)state userInfo:(id)userInfo {
    [self notifyOfStateWithSelector:[self selectorForState:state] userInfo:userInfo];
}

- (void)performBlockWithNotifications:(void (^)(void))block {
    [self performBlock:block postNotifications:YES];
}

- (void)performBlockWithoutNotifications:(void (^)(void))block {
    [self performBlock:block postNotifications:NO];
}

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateWithSelector:(SEL)aSelector userInfo:(id)userInfo {
    @synchronized (self) {
        if (!self.postNotifications) {
            return;
        }
        
        for (id observer in self.mutableListeners) {
            if ([observer respondsToSelector:aSelector]) {
                AMPPragmaDiagnosticPushSelectorLeak
                [observer performSelector:aSelector withObject:self.target withObject:userInfo];
                AMPPragmaDiagnosticPop
            }
        }
    }
}

- (void)performBlock:(void (^)(void))block postNotifications:(BOOL)yesOrNo {
    if (!block) {
        return;
    }
    
    @synchronized (self) {
        BOOL postNotifications = self.postNotifications;
        self.postNotifications = yesOrNo;
        block();
        self.postNotifications = postNotifications;
    }
}

@end

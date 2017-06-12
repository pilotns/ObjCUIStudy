//
//  AMPObservableObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

#import "AMPMarcos.h"

@interface AMPObservableObject ()
@property (nonatomic, retain)   NSHashTable     *mutableObservers;

- (void)notifyOfStateWithSelector:(SEL)aSelector userInfo:(id)userInfo;

@end

@implementation AMPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    @synchronized (self) {
        return [self.mutableObservers setRepresentation];
    }
}

- (void)setState:(NSUInteger)state {
    [self setState:state userInfo:nil];
}

- (void)setState:(NSUInteger)state userInfo:(id)userInfo {
    @synchronized (self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfStateWithSelector:[self selectorForState:state] userInfo:userInfo];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer {
    @synchronized (self) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized (self) {
        [self.mutableObservers removeObject:observer];
    }
}

- (BOOL)isObserver:(id)observer {
    @synchronized (self) {
        return [self.mutableObservers containsObject:observer];
    }
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfState:state userInfo:nil];
}

- (void)notifyOfState:(NSUInteger)state userInfo:(id)userInfo {
    [self notifyOfStateWithSelector:[self selectorForState:state] userInfo:userInfo];
}

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateWithSelector:(SEL)aSelector userInfo:(id)userInfo {
    for (id observer in self.mutableObservers) {
        if ([observer respondsToSelector:aSelector]) {
AMPPragmaDiagnosticPushSelectorLeak
            [observer performSelector:aSelector withObject:self withObject:userInfo];
AMPPragmaDiagnosticPop
        }
    }
}

@end

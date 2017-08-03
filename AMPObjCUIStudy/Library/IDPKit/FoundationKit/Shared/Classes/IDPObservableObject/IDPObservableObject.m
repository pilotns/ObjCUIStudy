//
//  IDPObservableObject.m
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPBlockMacros.h"
#import "IDPReturnMacros.h"

#import "IDPLocking.h"

@interface IDPObservableObject ()
@property (nonatomic, weak)     id<NSObject>    target;
@property (nonatomic, strong)   NSHashTable     *mutableObservers;
@property (nonatomic, strong)   id<IDPLocking>  lock;

@property (nonatomic, assign, getter=isNotificationEnabled)   BOOL  notificationEnabled;

- (void)setNotificationEnabled:(BOOL)notificationEnabled forBlock:(IDPVoidBlock)block;

@end

@implementation IDPObservableObject

@synthesize state   = _state;

#pragma mark -
#pragma mark Class Methods


+ (instancetype)objectWithTarget:(id<NSObject>)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)init {
    return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id<NSObject>)target {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    self.target = target ? target : self;
    self.lock = [NSRecursiveLock new];
    self.notificationEnabled = YES;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    NSHashTable *mutableObservers = self.mutableObservers;
    __block NSSet *result = nil;
    
    [self.lock performBlock:^{
        result = [mutableObservers setRepresentation];
    }];
    
    return result;
}

- (IDPObjectState)state {
    return _state;
}

- (void)setState:(IDPObjectState)state {
    [self setState:state object:nil];
}

- (void)setState:(IDPObjectState)state object:(id)object {
    [self.lock performBlock:^{
        if (_state != state) {
            _state = state;
            [self notifyObserversWithState:state object:object];
        }
    }];
}

#pragma mark -
#pragma mark Public

- (IDPObserver *)observer {
    IDPObserver *observer = [[IDPObserver alloc] initWithObservableObject:self];
    NSHashTable *mutableObservers = self.mutableObservers;
    
    [self.lock performBlock:^{
        [mutableObservers addObject:observer];
    }];
    
    return observer;
}

- (void)notifyObserversWithState:(IDPObjectState)state {
    [self notifyObserversWithState:state object:nil];
}

- (void)notifyObserversWithState:(IDPObjectState)state object:(id)object {
    NSHashTable *mutableObservers = self.mutableObservers;
    [self.lock performBlock:^{
        IDPReturnIfNil(self.notificationEnabled);
        
        for (IDPObserver *observer in mutableObservers) {
            [observer performBlockForState:state object:object];
        }
    }];
}

- (void)performBlockWithNotifications:(IDPVoidBlock)block {
    [self setNotificationEnabled:YES forBlock:block];
}

- (void)performBlockWithoutNotifications:(IDPVoidBlock)block {
    [self setNotificationEnabled:NO forBlock:block];
}

#pragma mark -
#pragma mark Private

- (void)setNotificationEnabled:(BOOL)enabled forBlock:(IDPVoidBlock)block {
    [self.lock performBlock:^{
        BOOL notificationEnabled = self.notificationEnabled;
        self.notificationEnabled = enabled;
        IDPBlockCall(block);
        self.notificationEnabled = notificationEnabled;
    }];
}

@end

//
//  AMPArrayModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModel.h"

#import "AMPUser.h"
#import "AMPArrayModelChange.h"
#import "AMPMacro.h"

#import "NSMutableArray+AMPExtensions.h"
#import "NSObject+AMPExtensions.h"
#import "NSIndexPath+AMPExtensions.h"
#import "NSNotificationCenter+AMPExtensions.h"

typedef void(^AMPVoidBlock)(void);

@interface AMPArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableObjects;

- (void)notifyOfStateChangeWithObject:(id)object;

@end

@implementation AMPArrayModel

@dynamic count;
@dynamic allObjects;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.mutableObjects = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    @synchronized (self) {
        return self.mutableObjects.count;
    }
}

- (NSArray *)allObjects {
    @synchronized (self) {
        return [self.mutableObjects copy];
    }
}

#pragma mark - 
#pragma mark Public Methods

- (void)addObject:(id)object {
    @synchronized (self) {
        [self insertObject:object atIndex:self.count];
    }
}

- (void)addObjects:(id<NSFastEnumeration>)objects {
    for (id object in objects) {
        [self addObject:object];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (!object) {
        return;
    }
    
    @synchronized (self) {
        if (index <= self.count) {
            AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeInsertWithIndex:index];
            
            [self.mutableObjects insertObject:object atIndex:index];
            [self notifyOfStateChangeWithObject:modelChange];
        }
    }
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndex:[self indexOfObject:object]];
}

- (void)removeObjects:(id<NSFastEnumeration>)objects {
    for (id object in objects) {
        [self removeObject:object];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        if (index < self.count) {
            AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeDeleteWithIndex:index];
            
            [self.mutableObjects removeObjectAtIndex:index];
            [self notifyOfStateChangeWithObject:modelChange];
        }
    }
}

- (void)moveObjectAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    if (sourceIndex == destinationIndex) {
        return;
    }
    
    @synchronized (self) {
        AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeMoveWithSourceIndex:sourceIndex
                                                                                   destinationIndex:destinationIndex];
        
        [self.mutableObjects moveObjectAtIndex:sourceIndex toIndex:destinationIndex];
        [self notifyOfStateChangeWithObject:modelChange];
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        return index < self.count ? self.mutableObjects[index] : nil;
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized (self) {
        return [self.mutableObjects indexOfObject:object];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateChangeWithObject:(id)object {
    [self notifyOfState:AMPArrayModelDidChange userInfo:object];
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AMPArrayModelDidChange:
            return @selector(arrayModel:didChangeWithArrayModelChange:);
    }
    
    return [super selectorForState:state];
}

@end

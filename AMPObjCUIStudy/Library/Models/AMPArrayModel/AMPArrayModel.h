//
//  AMPArrayModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

typedef NS_ENUM(NSUInteger, AMPArrayModelState) {
    AMPArrayModelDidChangeState = AMPModelStateCount
};

@class AMPArrayModelChange;
@class AMPArrayModel;

@protocol AMPArrayModelObserver <AMPModelObserver>

@optional
- (void)arrayModel:(AMPArrayModel *)model didChangeWithArrayModelChange:(AMPArrayModelChange *)info;

@end

@interface AMPArrayModel : AMPModel
@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSArray     *allObjects;

- (void)addObject:(id)object;
- (void)addObjects:(id<NSFastEnumeration>)objects;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;

- (void)removeObject:(id)object;
- (void)removeObjects:(id<NSFastEnumeration>)objects;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)moveObjectAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;

- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (NSUInteger)indexOfObject:(id)object;

@end

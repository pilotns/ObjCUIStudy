//
//  AMPArrayModelChange.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChange.h"

#import "AMPArrayModelChangeInsert.h"
#import "AMPArrayModelChangeDelete.h"
#import "AMPArrayModelChangeMove.h"

#import "NSIndexPath+AMPExtensions.h"

@interface AMPArrayModelChange ()
@property (nonatomic, strong)   NSIndexPath *indexPath;

@end

@implementation AMPArrayModelChange

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayModelChangeInsertWithIndex:(NSUInteger)index {
    return [[AMPArrayModelChangeInsert alloc] initWithIndex:index];
}

+ (instancetype)arrayModelChangeDeleteWithIndex:(NSUInteger)index {
    return [[AMPArrayModelChangeDelete alloc] initWithIndex:index];
}

+ (instancetype)arrayModelChangeMoveWithSourceIndex:(NSUInteger)sourceInde
                                   destinationIndex:(NSUInteger)destinationIndex
{
    return [[AMPArrayModelChangeMove alloc] initWithSourceIndex:sourceInde
                                               destinationIndex:destinationIndex];
}

@end

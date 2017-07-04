//
//  NSMutableArray+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 04.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSMutableArray+AMPExtensions.h"

@implementation NSMutableArray (AMPExtensions)

- (void)moveObjectAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    id object = [self objectAtIndex:sourceIndex];
    [self removeObjectAtIndex:sourceIndex];
    [self insertObject:object atIndex:destinationIndex];
}

@end

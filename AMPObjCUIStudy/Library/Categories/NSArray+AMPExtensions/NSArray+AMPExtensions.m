//
//  NSArray+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 15.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSArray+AMPExtensions.h"

@implementation NSArray (AMPExtensions)

+ (instancetype)objectsWithCount:(NSUInteger)count factoryBlock:(AMPFactoryBlock)block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        id object = block();
        [resultArray addObject:object];
    }
    
    return [self arrayWithArray:resultArray];
}

- (instancetype)objectsWithClass:(Class)class {
    return [self filteredObjectsUsingBlock:^BOOL(id object) {
        return [object isMemberOfClass:class];
    }];
}

- (instancetype)filteredObjectsUsingBlock:(BOOL(^)(id object))block {
    if (!block) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, id bindings) {
        return block(evaluatedObject);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

@end

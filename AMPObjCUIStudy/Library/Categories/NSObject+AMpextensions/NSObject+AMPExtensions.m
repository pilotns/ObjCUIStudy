//
//  NSObject+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 14.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSObject+AMPExtensions.h"

#import "NSArray+AMPExtensions.h"

@implementation NSObject (AMPExtensions)

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count factoryBlock:^id{
        return [self new];
    }];
}



@end

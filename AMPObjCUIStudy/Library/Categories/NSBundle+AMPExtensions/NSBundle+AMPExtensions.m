//
//  NSBundle+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSBundle+AMPExtensions.h"

#import "NSArray+AMPExtensions.h"

@implementation NSBundle (AMPExtensions)

- (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil options:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    NSArray *topLevelObjects = [self loadNibNamed:NSStringFromClass([class class]) owner:owner options:options];
    
    return [[topLevelObjects objectsWithClass:class] firstObject];
}

@end

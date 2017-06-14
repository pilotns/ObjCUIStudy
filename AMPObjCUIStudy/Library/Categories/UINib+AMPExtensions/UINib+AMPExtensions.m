//
//  UINib+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "UINib+AMPExtensions.h"

#import "NSArray+AMPExtensions.h"

@implementation UINib (AMPExtensions)

+ (instancetype)nibWithClass:(Class)class {
    return [self nibWithClass:class inBundle:[NSBundle mainBundle]];
}

+ (instancetype)nibWithClass:(Class)cls inBundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass([cls class]) bundle:bundle];
}

+ (id)objectWithClass:(Class)class {
    return [self objectWithClass:class inBundle:[NSBundle mainBundle]];
}

+ (id)objectWithClass:(Class)class inBundle:(NSBundle *)bundle {
    return [self objectWithClass:class inBundle:bundle owner:nil options:nil];
}

+ (id)objectWithClass:(Class)class inBundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options {
    UINib *nib = [self nibWithClass:class inBundle:bundle];
    NSArray *topLevelObjects = [nib instantiateWithOwner:owner options:options];
    
    return [[topLevelObjects objectsWithClass:class] firstObject];
}



@end

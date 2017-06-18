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
    return [self nibWithClass:class bundle:[NSBundle mainBundle]];
}

+ (instancetype)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass([cls class]) bundle:bundle];
}

+ (id)objectWithClass:(Class)class {
    return [self objectWithClass:class bundle:[NSBundle mainBundle]];
}

+ (id)objectWithClass:(Class)class bundle:(NSBundle *)bundle {
    return [self objectWithClass:class bundle:bundle owner:nil options:nil];
}

+ (id)objectWithClass:(Class)class bundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options {
    UINib *nib = [self nibWithClass:class bundle:bundle];
    
    return [nib objectWithClass:class bundle:bundle owner:owner options:options];
}

- (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls bundle:[NSBundle mainBundle]];
}

- (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [self objectWithClass:cls bundle:bundle owner:nil options:nil];
}

- (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    
    return [[objects objectsWithClass:cls] firstObject];
}

@end

//
//  UITableView+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "UITableView+AMPExtensions.h"

#import "UINib+AMPExtensions.h"

@implementation UITableView (AMPExtensions)

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass([class class])];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

@end

//
//  NSIndexPath+AMPExtensions.m.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSIndexPath+AMPExtensions.h"

#import <UIKit/UITableView.h>

@implementation NSIndexPath (AMPExtensions)

+ (instancetype)indexPathForRow:(NSUInteger)row {
    return [self indexPathForRow:row inSection:0];
}

@end

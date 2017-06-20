//
//  AMPArrayModelChangeInsert.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeInsert.h"

#import "AMPArrayModelChange+AMPPrivate.h"

#import "NSIndexPath+AMPExtensions.h"

@implementation AMPArrayModelChangeInsert

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView insertRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

@end

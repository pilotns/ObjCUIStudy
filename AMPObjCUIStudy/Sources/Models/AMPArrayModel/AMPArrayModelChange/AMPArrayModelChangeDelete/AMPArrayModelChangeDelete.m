//
//  AMPArrayModelChangeDelete.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeDelete.h"

#import "AMPArrayModelChange+AMPPrivate.h"

#import "NSIndexPath+AMPExtensions.h"

@implementation AMPArrayModelChangeDelete

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

@end

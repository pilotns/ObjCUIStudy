//
//  AMPArrayModelChange+UITableView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChange+UITableView.h"

@implementation AMPArrayModelChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [self applyToTableView:tableView section:0];
}

- (void)applyToTableView:(UITableView *)tableView section:(NSUInteger)section {
    [self applyToTableView:tableView section:section rowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)applyToTableView:(UITableView *)tableView
                 section:(NSUInteger)section
            rowAnimation:(UITableViewRowAnimation)animation
{
    
}

@end

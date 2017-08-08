//
//  AMPArrayModelChange+UITableView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChange.h"

@interface AMPArrayModelChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView;
- (void)applyToTableView:(UITableView *)tableView section:(NSUInteger)section;

- (void)applyToTableView:(UITableView *)tableView
                 section:(NSUInteger)section
            rowAnimation:(UITableViewRowAnimation)animation;

@end

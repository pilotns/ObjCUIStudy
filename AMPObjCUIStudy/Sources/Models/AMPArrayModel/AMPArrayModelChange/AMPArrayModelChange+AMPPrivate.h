//
//  AMPArrayModelChange+AMPPrivate.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChange.h"

@interface AMPArrayModelChange (AMPPrivate)

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation;

@end

//
//  AMPArrayModelChangeDelete.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeDelete.h"

#import "NSIndexPath+AMPExtensions.h"
#import "UITableView+AMPExtensions.h"

@interface AMPArrayModelChangeDelete ()
@property (nonatomic, assign)   NSUInteger  index;

@end

@implementation AMPArrayModelChangeDelete

#pragma mark -
#pragma mark Initializarions and Deallocations

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    self.index = index;
    
    return self;
}

#pragma mark -
#pragma mark AMPArrayModelChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView
                 section:(NSUInteger)section
            rowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:section];
    [tableView updateWithBlock:^{
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

@end

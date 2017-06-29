//
//  AMPArrayModelChangeInsert.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeInsert.h"

#import "NSIndexPath+AMPExtensions.h"
#import "UITableView+AMPExtensions.h"

@interface AMPArrayModelChangeInsert ()
@property (nonatomic, assign)   NSUInteger  index;

@end

@implementation AMPArrayModelChangeInsert

#pragma mark -
#pragma mark Initializations and Deallocations

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
        [tableView insertRowAtIndexPath:indexPath withRowAnimation:animation];
    }];
}

@end

//
//  AMPArrayModelChange.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChange.h"

#import "AMPArrayModelChangeInsert.h"
#import "AMPArrayModelChangeDelete.h"
#import "AMPArrayModelChangeMove.h"

#import "NSIndexPath+AMPExtensions.h"

@implementation AMPArrayModelChange

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayModelChangeInsertWithIndex:(NSUInteger)index {
    return [[AMPArrayModelChangeInsert alloc] initWithIndex:index];
}

+ (instancetype)arrayModelChangeDeleteWithIndex:(NSUInteger)index {
    return [[AMPArrayModelChangeDelete alloc] initWithIndex:index];
}

+ (instancetype)arrayModelChangeMoveWithSourceIndex:(NSUInteger)sourceIndex
                                   destinationIndex:(NSUInteger)destinationIndex
{
    return [[AMPArrayModelChangeMove alloc] initWithSourceIndex:sourceIndex
                                               destinationIndex:destinationIndex];
}

@end

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

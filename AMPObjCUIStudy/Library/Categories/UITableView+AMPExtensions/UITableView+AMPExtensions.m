//
//  UITableView+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "UITableView+AMPExtensions.h"

#import "AMPArrayModelChange.h"

#import "UINib+AMPExtensions.h"

@implementation UITableView (AMPExtensions)

- (id)reusableCellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass([class class])];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

- (void)updateWithBlock:(void (^)(void))block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

- (void)updateWithArrayModelChange:(AMPArrayModelChange *)modelChange {
    [self updateWithArrayModelChange:modelChange inSection:0];
}

- (void)updateWithArrayModelChange:(AMPArrayModelChange *)modelChange inSection:(NSUInteger)section {
    [modelChange applyToTableView:self section:section];
}

- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

@end

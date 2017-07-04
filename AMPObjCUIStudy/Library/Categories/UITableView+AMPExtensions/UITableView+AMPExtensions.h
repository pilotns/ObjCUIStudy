//
//  UITableView+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPArrayModelChange;

@interface UITableView (AMPExtensions)

- (id)reusableCellWithClass:(Class)class;

- (void)updateWithBlock:(void (^)(void))block;

- (void)updateWithArrayModelChange:(AMPArrayModelChange *)modelChange;
- (void)updateWithArrayModelChange:(AMPArrayModelChange *)modelChange inSection:(NSUInteger)section;

- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

@end

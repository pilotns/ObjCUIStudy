//
//  AMPArrayModelChange.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPArrayModelChange : NSObject

+ (instancetype)arrayModelChangeInsertWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeDeleteWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeMoveWithSourceIndex:(NSUInteger)sourceIndex
                                   destinationIndex:(NSUInteger)destinationIndex;

@end

@interface AMPArrayModelChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView;
- (void)applyToTableView:(UITableView *)tableView section:(NSUInteger)section;

- (void)applyToTableView:(UITableView *)tableView
                 section:(NSUInteger)section
            rowAnimation:(UITableViewRowAnimation)animation;

@end

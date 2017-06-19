//
//  AMPUsersViewController.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPArrayModel;

@interface AMPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   AMPArrayModel   *users;

- (void)onAdd:(UIBarButtonItem *)sender;
- (void)onEdit:(UIBarButtonItem *)sender;

@end

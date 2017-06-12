//
//  AMPUsersViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersViewController.h"

#import "AMPUsersView.h"
#import "AMPUsersModel.h"
#import "AMPUserCell.h"

#import "AMPMarcos.h"

#import "UITableView+AMPExtensions.h"

AMPDefineBaseViewProperty(AMPUsersViewController, AMPUsersView, usersView);


@interface AMPUsersViewController ()

- (void)fillWithModel:(AMPUsersModel *)model;

@end

@implementation AMPUsersViewController

#pragma mark -
#pragma mark Accessers

- (void)setUsers:(AMPUsersModel *)users {
    if (_users != users) {
        _users = users;
    }
    
    [self fillWithModel:users];
    [self.usersView.tableView reloadData];
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usersView.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMPUserCell *userCell = [tableView cellWithClass:[AMPUserCell class]];

    userCell.user = self.users[indexPath.row];
    
    return userCell;
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(AMPUsersModel *)model {
    self.navigationItem.title = model.title;
}


@end

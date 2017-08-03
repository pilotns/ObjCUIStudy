//
//  AMPFBUsersViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUsersViewController.h"

#import "AMPFBUserViewController.h"

#import "AMPFBUser.h"
#import "AMPFBUsersView.h"
#import "AMPUsersModel.h"
#import "AMPFBGetUsersContext.h"
#import "AMPGCDExtensions.h"
#import "AMPUserCell.h"

#import "AMPMacro.h"

#import "UITableView+AMPExtensions.h"

AMPSynthesizeBaseViewProperty(AMPFBUsersViewController, AMPFBUsersView, rootView);

@interface AMPFBUsersViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly) AMPUsersModel   *usersModel;

@end

@implementation AMPFBUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AMPFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.model = user.friends;
    }
}

- (AMPUsersModel *)usersModel {
    return self.model;
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(id)model {
    self.navigationItem.title = @"Friends";
    [self.rootView.tableView reloadData];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.context = [[AMPFBGetUsersContext alloc] initWithModel:self.model];
}

#pragma mark -
#pragma mark AMPArrayModelObserver

- (void)arrayModel:(AMPArrayModel *)model didChangeWithArrayModelChange:(AMPArrayModelChange *)info {
    AMPDispatchSyncOnMainQueue(^{
        [self.rootView.tableView updateWithArrayModelChange:info];
    });
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.usersModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMPUserCell *cell = [tableView reusableCellWithClass:[AMPUserCell class]];
    
    cell.user = self.usersModel[indexPath.row];
    
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMPUserCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AMPFBUserViewController *userController = [AMPFBUserViewController new];
    userController.model = cell.user;
    
    [self.navigationController pushViewController:userController animated:YES];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView
         accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDisclosureIndicator;
}

@end

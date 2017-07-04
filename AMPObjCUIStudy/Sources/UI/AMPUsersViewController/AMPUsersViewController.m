//
//  AMPUsersViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersViewController.h"

#import "AMPUsersModel.h"
#import "AMPUser.h"

#import "AMPUsersView.h"
#import "AMPUserCell.h"

#import "AMPMacro.h"

#import "AMPGCDExtensions.h"

#import "UITableView+AMPExtensions.h"
#import "NSIndexPath+AMPExtensions.h"
#import "UINib+AMPExtensions.h"

AMPSynthesizeBaseViewProperty(AMPUsersViewController, AMPUsersView, usersView);

static NSString * const AMPNavigationControllerTitle    = @"Users";

@interface AMPUsersViewController () <AMPModelObserver, AMPArrayModelObserver>

- (void)fillWithModel:(AMPModel *)model;

- (void)initBarButtonItems;
- (UIBarButtonItem *)editButtonWithSystemItem:(UIBarButtonSystemItem)systemItem;

@end

@implementation AMPUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.users = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self initBarButtonItems];
    
    return self;
}

#pragma mark -
#pragma mark Accessers

- (void)setUsers:(AMPUsersModel *)users {
    if (_users != users) {
        [_users removeObserver:self];
        
        _users = users;
        [_users addObserver:self];
    }

    [users load];
}

#pragma mark -
#pragma mark Actions

- (void)onAdd:(UIBarButtonItem *)sender {
    AMPUsersModel *users = self.users;
    if (AMPModelDidLoad == users.state) {
        [users addObject:[AMPUser new]];
    }
}

- (void)onEdit:(UIBarButtonItem *)sender {
    UITableView *tableView = self.usersView.tableView;
    [tableView setEditing:!tableView.isEditing animated:YES];
    
    UIBarButtonSystemItem systemItem = tableView.isEditing
                                        ? UIBarButtonSystemItemDone
                                        : UIBarButtonSystemItemEdit;

    self.navigationItem.rightBarButtonItem = [self editButtonWithSystemItem:systemItem];
}

#pragma mark -
#pragma mark View LifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.users load];
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(AMPModel *)model {
    self.navigationItem.title = AMPNavigationControllerTitle;
    [self.usersView.tableView reloadData];
}

- (UIBarButtonItem *)editButtonWithSystemItem:(UIBarButtonSystemItem)systemItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                         target:self
                                                         action:@selector(onEdit:)];
}

- (void)initBarButtonItems {
    UIBarButtonItem *edit = [self editButtonWithSystemItem:UIBarButtonSystemItemEdit];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(onAdd:)];
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.leftBarButtonItem = add;
    navigationItem.rightBarButtonItem = edit;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMPUserCell *userCell = [tableView reusableCellWithClass:[AMPUserCell class]];

    userCell.user = self.users[indexPath.row];
    
    return userCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.users removeObjectAtIndex:indexPath.row];
    }
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.users moveObjectAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return UITableViewCellEditingStyleDelete;
}

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(AMPUserCell *)cell
    forRowAtIndexPath:(NSIndexPath*)indexPath
{
    cell.user = nil;
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    AMPDispatchAsyncOnMainQueue(^{
        [self.usersView setLoadingViewVisibleAnimated:YES];
    });
}

- (void)modelDidLoad:(id)model {
    AMPDispatchAsyncOnMainQueue(^{
        [self fillWithModel:model];
        [self.usersView setLoadingViewHiddenAnimated:YES];
    });
}

#pragma mark -
#pragma mark AMPArrayModelObserver

- (void)arrayModel:(AMPArrayModel *)model didChangeWithArrayModelChange:(AMPArrayModelChange *)info {
    AMPDispatchSyncOnMainQueue(^{
        [self.usersView.tableView updateWithArrayModelChange:info];
    });
}

@end

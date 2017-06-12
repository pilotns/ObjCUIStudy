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

#import "AMPMarcos.h"

#import "UITableView+AMPExtensions.h"
#import "AMPUsersModelChangesInfo.h"

AMPDefineBaseViewProperty(AMPUsersViewController, AMPUsersView, usersView);


@interface AMPUsersViewController () <AMPUsersModelObserver>

- (void)fillWithModel:(AMPUsersModel *)model;

@end

@implementation AMPUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.users = nil;
}

#pragma mark -
#pragma mark Accessers

- (void)setUsers:(AMPUsersModel *)users {
    if (_users != users) {
        [_users removeObserver:self];
        
        _users = users;
        [_users addObserver:self];
    }
    
    [self fillWithModel:users];
    [self.usersView.tableView reloadData];
}

#pragma mark -
#pragma mark Actions

- (IBAction)onAdd:(UIBarButtonItem *)sender {
    [self.users addUser:[AMPUser new]];
}

- (IBAction)onEdit:(UIBarButtonItem *)sender {
    UITableView *tableView = self.usersView.tableView;
    
    [tableView setEditing:!tableView.isEditing animated:YES];
    
    UIBarButtonItem *button = nil;
    if (tableView.isEditing) {
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                               target:self
                                                               action:@selector(onEdit:)];
    } else {
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                               target:self
                                                               action:@selector(onEdit:)];
    }
    
    self.navigationItem.rightBarButtonItem = button;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                          target:self
                                                                          action:@selector(onEdit:)];
    
    self.navigationItem.rightBarButtonItem = edit;
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(onAdd:)];
    
    self.navigationItem.leftBarButtonItem = add;
    
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-   (void)tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.users removeUserAtIndex:indexPath.row];
    }
}

-   (void)tableView:(UITableView *)tableView
 moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.users moveUserAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
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

#pragma mark -
#pragma mark AMPUsersModelObserver

- (void)usersModel:(AMPUsersModel *)model didChangeStateWithInfo:(AMPUsersModelChangesInfo *)info {
    switch (info.type) {
        case AMPUsersModelChangesTypeAdd:
            [self.usersView.tableView insertRowsAtIndexPaths:info.indexPaths withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        case AMPUsersModelChangesTypeRemove:
            [self.usersView.tableView deleteRowsAtIndexPaths:info.indexPaths withRowAnimation:UITableViewRowAnimationRight];
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(AMPUsersModel *)model {
    self.navigationItem.title = model.title;
}

@end

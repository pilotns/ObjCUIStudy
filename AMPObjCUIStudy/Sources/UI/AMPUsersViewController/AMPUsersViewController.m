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
#import "NSIndexPath+AMPExtensions.h"

AMPDefineBaseViewProperty(AMPUsersViewController, AMPUsersView, usersView);

static NSString * const AMPSortButtonTitle = @"Sort";

@interface AMPUsersViewController () <AMPUsersModelObserver>

- (void)fillWithModel:(AMPUsersModel *)model;
- (void)performUpdatesWithPreviousStateOfModel:(AMPUsersModel *)model;

- (UIBarButtonItem *)editButtonWithSystemIntem:(UIBarButtonSystemItem)systemItem;

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
}

#pragma mark -
#pragma mark Actions

- (void)onAdd:(UIBarButtonItem *)sender {
    [self.users addUser:[AMPUser new]];
}

- (void)onEdit:(UIBarButtonItem *)sender {
    UITableView *tableView = self.usersView.tableView;
    [tableView setEditing:!tableView.isEditing animated:YES];
    
    UIBarButtonSystemItem systemItem = tableView.isEditing
                                        ? UIBarButtonSystemItemDone
                                        : UIBarButtonSystemItemEdit;

    self.navigationItem.rightBarButtonItem = [self editButtonWithSystemIntem:systemItem];
}

- (void)onSort:(UIBarButtonItem *)sender {
    [self.users performSorting];
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *edit = [self editButtonWithSystemIntem:UIBarButtonSystemItemEdit];
    
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithTitle:AMPSortButtonTitle
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(onSort:)];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(onAdd:)];
    self.navigationItem.leftBarButtonItem = add;
    self.navigationItem.rightBarButtonItems = @[edit, sort];
    
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

- (void)usersModel:(AMPUsersModel *)model didChangeStateWithInfo:(id)info {
    UITableView *tableView = self.usersView.tableView;
    switch (model.state) {
        case AMPUsersModelChangesTypeAdd:
            [tableView insertRowAtIndexPath:info withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        case AMPUsersModelChangesTypeRemove:
            [tableView deleteRowAtIndexPath:info withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case AMPUsersModelChangesTypeSorting:
            [self performUpdatesWithPreviousStateOfModel:info];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(AMPUsersModel *)model {
    self.navigationItem.title = model.title;
    
    [self.usersView.tableView reloadData];
}

- (void)performUpdatesWithPreviousStateOfModel:(AMPUsersModel *)model {
    UITableView *tableView = self.usersView.tableView;
    AMPUsersModel *currentModel = self.users;
    
    [tableView performUpdatesWithBlock:^{
        for (id user in model) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[currentModel indexOfUser:user]];
            NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:[model indexOfUser:user]];
            
            [tableView moveRowAtIndexPath:previousIndexPath toIndexPath:newIndexPath];
        }
    }];
}

- (UIBarButtonItem *)editButtonWithSystemIntem:(UIBarButtonSystemItem)systemItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                         target:self
                                                         action:@selector(onEdit:)];
}

@end

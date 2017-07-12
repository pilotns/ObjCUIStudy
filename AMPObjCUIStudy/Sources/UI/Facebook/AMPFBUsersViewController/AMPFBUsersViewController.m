//
//  AMPFBUsersViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUsersViewController.h"

#import "AMPFBUsersView.h"
#import "AMPUsersModel.h"
#import "AMPFBGetUsersContext.h"
#import "AMPGCDExtensions.h"
#import "AMPUserCell.h"

#import "AMPMacro.h"

#import "UITableView+AMPExtensions.h"

AMPSynthesizeBaseViewProperty(AMPFBUsersViewController, AMPFBUsersView, usersView);

@interface AMPFBUsersViewController () <UITableViewDelegate, UITableViewDataSource>

- (void)fillWithModel:(id)model;

@end

@implementation AMPFBUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.usersModel = [AMPUsersModel new];
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

- (void)setUsersModel:(AMPUsersModel *)usersModel {
    if (_usersModel != usersModel) {
        [_usersModel removeObserver:self];
        
        _usersModel = usersModel;
        [usersModel addObserver:self];
    }
}

- (void)setContext:(AMPFBGetUsersContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(id)model {
    self.navigationItem.title = @"Friends";
    [self.usersView.tableView reloadData];
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self.usersView setLoadingViewVisible:YES];
    });
}

- (void)modelDidLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self fillWithModel:model];
        [self.usersView setLoadingViewVisible:NO];
    });
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.usersModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMPUserCell *cell = [tableView reusableCellWithClass:[AMPUserCell class]];
    
    cell.user = [self.usersModel objectAtIndex:indexPath.row];
    
    return cell;
}

@end

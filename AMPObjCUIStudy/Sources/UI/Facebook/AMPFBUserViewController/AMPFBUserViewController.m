//
//  AMPFBUserViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUserViewController.h"

#import "AMPGCDExtensions.h"
#import "AMPFBGetUserContext.h"
#import "AMPFBUserView.h"
#import "AMPFBUser.h"

#import "AMPFBGetUsersContext.h"
#import "AMPFBUsersViewController.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBUserViewController, AMPFBUserView, userView);

@interface AMPFBUserViewController ()
@property (nonatomic, strong)   AMPFBUser           *user;

@end

@implementation AMPFBUserViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.user = [AMPFBUser new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AMPFBUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [user addObserver:self];
    }
}

- (void)setContext:(AMPFBGetUserContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onFriendsButton:(id)sender {
    AMPFBUsersViewController *usersViewController = [AMPFBUsersViewController new];
    AMPFBGetUsersContext *context = [[AMPFBGetUsersContext alloc] initWithModel:usersViewController.usersModel
                                                                      graphPath:self.user.fbUserID
                                                                     parameters:@{@"fields" : @"friends{first_name,last_name,id,picture}"}];
    
    usersViewController.context = context;
    [self.navigationController pushViewController:usersViewController animated:YES];
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
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self.userView setLoadingViewVisible:YES];
    });
}

- (void)modelDidLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        self.navigationItem.title = self.user.fullName;
        [self.userView fillWithUser:model];
        [self.userView setLoadingViewVisible:NO];
    });
}

@end

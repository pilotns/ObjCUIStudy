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
#import "AMPFBViewController.h"

#import "AMPFBGetUsersContext.h"
#import "AMPFBUsersViewController.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBUserViewController, AMPFBUserView, rootView);

@interface AMPFBUserViewController ()
@property (nonatomic, readonly) AMPFBUser *user;

- (void)prepareFriendsButton;

@end

@implementation AMPFBUserViewController

#pragma mark -
#pragma mark - Accessors

- (AMPFBUser *)user {
    return self.model;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onFriendsButton:(UIButton *)sender {
    AMPFBUsersViewController *usersController = [AMPFBUsersViewController new];
    usersController.user = self.user;
    
    [self.navigationController pushViewController:usersController animated:YES];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(id)model {
    self.navigationItem.title = self.user.fullName;
    [self.rootView fillWithUser:model];
    [self prepareFriendsButton];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.user.isAuthorized) {
        [self fillWithModel:self.model];
    } else {
        self.context = [[AMPFBGetUserContext alloc] initWithModel:self.model];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareFriendsButton {
    if (!self.user.isAuthorized) {
        self.rootView.friendsButton.hidden = YES;
    }
}

@end

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
    return (AMPFBUser *)self.model;
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
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareFriendsButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    AMPFBUser *user = self.user;
    NSDictionary *parameters = @{@"fields" : @"first_name,last_name,picture.type(large)"};
    self.context = [[AMPFBGetUserContext alloc] initWithModel:user
                                                    graphPath:user.fbUserID
                                                   parameters:parameters];
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareFriendsButton {
    if (![[FBSDKAccessToken currentAccessToken].userID isEqualToString:self.user.fbUserID]) {
        self.rootView.friendsButton.hidden = YES;
    }
}

@end

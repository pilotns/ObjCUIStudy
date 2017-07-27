//
//  AMPFBLoginViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginViewController.h"

#import "AMPFBUser.h"
#import "AMPFBLoginView.h"
#import "AMPFBUsersViewController.h"

#import "AMPFBLoginContext.h"
#import "AMPFBLogoutContext.h"
#import "AMPFBGetUserContext.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBLoginViewController, AMPFBLoginView, loginView);

@interface AMPFBLoginViewController () <AMPContextObserver>
@property (nonatomic, readonly) FBSDKAccessToken    *accessToken;

- (void)prepareLoginButton;
- (void)presentUsersViewController;

@end

@implementation AMPFBLoginViewController

#pragma mark -
#pragma mark Accessors

- (FBSDKAccessToken *)accessToken {
    return [FBSDKAccessToken currentAccessToken];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onLoginButton:(UIButton *)sender {
    Class contextClass = self.accessToken
                            ? [AMPFBLogoutContext class]
                            : [AMPFBLoginContext class];
    
    self.context = [contextClass new];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareLoginButton];
    if (self.accessToken) {
        [self presentUsersViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareLoginButton {
    NSString *buttonTitle = self.accessToken ? @"Logout" : @"Login to Facebook";
    
    [self.loginView.loginButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)presentUsersViewController {
    AMPFBUsersViewController *usersController = [AMPFBUsersViewController new];
    usersController.user = [[AMPFBUser alloc] initWithFbUserID:self.accessToken.userID];
    
    [self.navigationController pushViewController:usersController animated:YES];
}

#pragma mark -
#pragma mark AMPContextObserver

- (void)context:(AMPContext *)context didFinishExecutingWithError:(NSError *)error {
    if (!error) {
        [self prepareLoginButton];
        if (self.accessToken) {
            [self presentUsersViewController];
        }
    }
}

@end

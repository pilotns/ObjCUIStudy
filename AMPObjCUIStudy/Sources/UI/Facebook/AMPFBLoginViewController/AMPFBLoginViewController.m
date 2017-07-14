//
//  AMPFBLoginViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginViewController.h"

#import "AMPFBLoginView.h"
#import "AMPFBUserViewController.h"

#import "AMPFBLoginContext.h"
#import "AMPFBLogoutContext.h"
#import "AMPFBGetUserContext.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBLoginViewController, AMPFBLoginView, loginView);

@interface AMPFBLoginViewController () <AMPContextObserver>
@property (nonatomic, strong)   AMPContext          *context;
@property (nonatomic, readonly) FBSDKAccessToken    *accessToken;

- (void)prepareLoginButton;

@end

@implementation AMPFBLoginViewController

#pragma mark -
#pragma mark Accessors

- (void)setContext:(AMPContext *)context {
    if (_context != context) {
        [_context cancel];
        [_context removeObserver:self];
        
        _context = context;
        [context addObserver:self];
        [context execute];
    }
}

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

#pragma mark -
#pragma mark AMPContextObserver

- (void)context:(AMPContext *)context didFinishExecutingWithError:(NSError *)error {
    if (!error) {
        [self prepareLoginButton];
        if (self.accessToken) {
            AMPFBUserViewController *userController = [AMPFBUserViewController new];
            userController.context = [[AMPFBGetUserContext alloc] initWithModel:userController.user
                                                                      graphPath:@"me"
                                                                     parameters:@{@"fields" : @"first_name,last_name,picture.type(large)"}];
            
            [self.navigationController pushViewController:userController animated:YES];
        }
    }
}

@end

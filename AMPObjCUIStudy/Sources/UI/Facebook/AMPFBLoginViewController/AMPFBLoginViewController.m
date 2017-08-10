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
#import "AMPFBUserViewController.h"

#import "AMPFBLoginContext.h"
#import "AMPFBLogoutContext.h"
#import "AMPFBGetUserContext.h"
#import "AMPGCDExtensions.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBLoginViewController, AMPFBLoginView, rootView);

@interface AMPFBLoginViewController ()
@property (nonatomic, readonly) AMPFBUser   *user;

- (void)loadModel;
- (void)presentUserViewController;

@end

@implementation AMPFBLoginViewController

#pragma mark -
#pragma mark Accessors

- (AMPFBUser *)user {
    return self.model;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onLoginButton:(UIButton *)sender {
    Class contextClass = self.isAuthorized
    ? [AMPFBLogoutContext class]
    : [AMPFBLoginContext class];
    
    self.context = [[contextClass alloc] initWithUser:self.model
                                            viewController:self];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rootView prepareLoginButton];
    [self loadModel];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadModel {
    if (self.isAuthorized) {
        self.context = [[AMPFBLoginContext alloc] initWithUser:self.model
                                                viewController:self];
    }
}

- (void)presentUserViewController {
    AMPFBUserViewController *userController = [AMPFBUserViewController new];
    userController.model = self.model;
    
    [self.navigationController pushViewController:userController animated:YES];
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelDidUnload:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        self.context = nil;
        [self.rootView prepareLoginButton];
    });
}

- (void)modelDidLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self.rootView prepareLoginButton];
        [self presentUserViewController];
    });
}

@end

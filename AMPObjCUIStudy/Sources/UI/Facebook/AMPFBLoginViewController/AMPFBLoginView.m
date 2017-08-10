//
//  AMPFBLoginView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginView.h"

static NSString * const kAMPLoginButtonLoginTitle   = @"Login to Facebook";
static NSString * const kAMPLoginButtonLogoutTitle  = @"Logout";

@implementation AMPFBLoginView

#pragma mark -
#pragma mark Public Methods

- (void)prepareLoginButton {
    NSString *buttonTitle = [FBSDKAccessToken currentAccessToken]
                                ? kAMPLoginButtonLogoutTitle
                                : kAMPLoginButtonLoginTitle;
    
    [self.loginButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end

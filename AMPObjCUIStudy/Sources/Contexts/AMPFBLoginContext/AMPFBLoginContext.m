//
//  AMPFBLoginContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginContext.h"

#import "AMPGCDExtensions.h"

#import "AMPMacro.h"

@interface AMPFBLoginContext ()
@property (nonatomic, strong)   FBSDKLoginManager   *loginManager;

@end

@implementation AMPFBLoginContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

#pragma mark -
#pragma mark Public Methods

- (void)performExecutionWithCompletionHandler:(void (^)(NSError *))completionHandler {
    if (!completionHandler) {
        return;
    }
    
    if ([FBSDKAccessToken currentAccessToken]) {
        completionHandler(nil);
    }
    
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"user_friends"]
                        fromViewController:nil
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       completionHandler(error);
                                   }];
    
    self.loginManager = loginManager;
}


- (void)cancel {
    [self.loginManager logOut];
}

@end

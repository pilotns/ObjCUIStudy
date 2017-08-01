//
//  AMPFBLoginContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginContext.h"

#import "AMPFBGetUserContext.h"
#import "AMPGCDExtensions.h"

#import "AMPMacro.h"

@interface AMPFBLoginContext ()
@property (nonatomic, readonly, getter=isAuthorized)    BOOL    authorized;

@property (nonatomic, strong)   FBSDKLoginManager   *loginManager;
@property (nonatomic, strong)   AMPFBGetUserContext *context;

- (void)loadModel;

@end

@implementation AMPFBLoginContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAuthorized {
    return nil != [FBSDKAccessToken currentAccessToken];
}

- (void)setContext:(AMPFBGetUserContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    if (self.isAuthorized) {
        [self loadModel];
    }
    
    AMPWeakify(self);
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"user_friends"]
                        fromViewController:nil
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       AMPStrongifyAndReturnIfNil(self);
                                       [self loadModel];
                                   }];
    
    self.loginManager = loginManager;
}


- (void)cancel {
    [self.loginManager logOut];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadModel {
    self.context = [[AMPFBGetUserContext alloc] initWithModel:self.model];
}

@end

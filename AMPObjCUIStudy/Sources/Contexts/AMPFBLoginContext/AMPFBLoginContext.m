//
//  AMPFBLoginContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLoginContext.h"

#import "AMPFBUser.h"
#import "AMPFBGetUserContext.h"
#import "AMPGCDExtensions.h"

#import "AMPFBViewController.h"

#import "AMPMacro.h"

@interface AMPFBLoginContext ()
@property (nonatomic, strong)   FBSDKLoginManager   *loginManager;
@property (nonatomic, readonly) NSArray             *readPermissions;
@property (nonatomic, strong)   AMPFBGetUserContext *context;


- (void)loadUserWithFacebokUserID:(NSString *)userID;

@end

@implementation AMPFBLoginContext

@dynamic readPermissions;

#pragma mark -
#pragma mark Accessors

- (void)setContext:(AMPFBGetUserContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

- (NSArray *)readPermissions {
    return @[@"public_profile", @"user_friends"];
}

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    if (self.authorizedUserID) {
        [self loadUserWithFacebokUserID:self.authorizedUserID];
        return;
    }
    
    AMPWeakify(self);
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logInWithReadPermissions:self.readPermissions
                        fromViewController:nil
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       AMPStrongifyAndReturnIfNil(self);
                                       if (!result.isCancelled && !error) {
                                           [self loadUserWithFacebokUserID:result.token.userID];
                                       }
                                   }];
    
    self.loginManager = loginManager;
}

- (void)cancel {
    [self.loginManager logOut];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadUserWithFacebokUserID:(NSString *)userID {
    AMPFBUser *user = [AMPFBUser managedObjectWithUserID:userID];
    self.viewController.model = user;
    
    self.context = [[AMPFBGetUserContext alloc] initWithUser:user
                                              viewController:self.viewController];
}

@end

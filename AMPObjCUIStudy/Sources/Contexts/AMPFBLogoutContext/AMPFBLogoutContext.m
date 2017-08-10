//
//  AMPFBLogoutContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLogoutContext.h"

#import "AMPModel.h"

@implementation AMPFBLogoutContext

#pragma mark -
#pragma mark Accessors

- (id)model {
    return self.user;
}

#pragma mark -
#pragma mark Public Methods

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    [[FBSDKLoginManager new] logOut];
    if (completionHandler) {
        completionHandler(AMPModelDidUnload, nil);
    }
}

@end

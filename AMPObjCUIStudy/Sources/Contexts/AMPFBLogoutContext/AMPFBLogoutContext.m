//
//  AMPFBLogoutContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBLogoutContext.h"

@implementation AMPFBLogoutContext

- (void)performExecutingWithCompletionHandler:(void (^)(NSError *))completionHandler {
    [[FBSDKLoginManager new] logOut];
    if (completionHandler) {
        completionHandler(nil);
    }
}

@end

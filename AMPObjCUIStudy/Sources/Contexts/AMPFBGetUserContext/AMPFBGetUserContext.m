//
//  AMPFBGetUserContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetUserContext.h"

#import "AMPFBUser.h"

#import "NSFileManager+AMPExtensions.h"

static NSString * const kAMPFBGetUserCachedResponseFileName = @"fbUser.plist";

@implementation AMPFBGetUserContext

#pragma mark -
#pragma mark Accessors

- (NSString *)cachedResponseFileName {
    NSString *fbUserID = [self.model fbUserID];
    
    return [NSString stringWithFormat:@"%@_%@", fbUserID, kAMPFBGetUserCachedResponseFileName];
}

#pragma mark -
#pragma mark Private Methods

- (void)handleResponse:(id)response {
    NSDictionary *result = @{kAMPFBUserID : response[@"id"],
                             kAMPFBUserFirstName : response[@"first_name"],
                             kAMPFBUserLastName : response[@"last_name"],
                             kAMPFBUserLargePictureURL : response[@"picture"][@"data"][@"url"]
                             };
    
    [self.model fillWithResponse:result];
}

@end

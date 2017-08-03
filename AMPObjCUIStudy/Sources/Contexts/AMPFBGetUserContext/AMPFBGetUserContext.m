//
//  AMPFBGetUserContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetUserContext.h"

#import "AMPFBUser.h"
#import "AMPFBResponseParser.h"

#import "NSFileManager+AMPExtensions.h"

static NSString * const kAMPFBGetUserCachedResponseFileName = @"fbUser.plist";

@interface AMPFBGetUserContext ()
@property (nonatomic, readonly) AMPFBUser   *user;

@end

@implementation AMPFBGetUserContext

#pragma mark -
#pragma mark Accessors

- (AMPFBUser *)user {
    return self.model;
}

- (NSString *)graphPath {
    NSString *fbUserID = self.user.userID;
    
    return fbUserID ? fbUserID : [FBSDKAccessToken currentAccessToken].userID;
}

- (NSDictionary *)parameters {
    return @{@"fields" : @"first_name,last_name,picture.type(large)"};
}

- (NSString *)cachedResponseFileName {
    NSString *userID = [self.model userID];
    
    return [NSString stringWithFormat:@"%@_%@", userID, kAMPFBGetUserCachedResponseFileName];
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResponse:(id)response {
    AMPFBUser *user = self.model;
    AMPFBResponseParser *parser = [AMPFBResponseParser parserWithResponse:response];
    
    user.userID = parser.userID;
    user.firstName = parser.firstName;
    user.lastName = parser.lastName;
    user.pictureURL = parser.pictureURL;
}

@end

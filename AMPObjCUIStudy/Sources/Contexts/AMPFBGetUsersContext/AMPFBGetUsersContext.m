//
//  AMPFBGetUsersContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetUsersContext.h"

#import "AMPFBUser.h"
#import "AMPUsersModel.h"
#import "AMPFBResponseParser.h"

#import "NSFileManager+AMPExtensions.h"

static NSString * const kAMPFBGetUsersCachedResponseFileName = @"fbUsers.plist";

@implementation AMPFBGetUsersContext

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return [FBSDKAccessToken currentAccessToken].userID;
}

- (NSDictionary *)parameters {
    return @{@"fields" : @"friends{first_name,last_name,id,picture}"};
}

- (NSString *)cachedResponseFileName {
    return kAMPFBGetUsersCachedResponseFileName;
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResponse:(id)response {
    AMPFBResponseParser *parser = [AMPFBResponseParser parserWithResponse:response];
    AMPUsersModel *model = self.model;
    
    [model performBlockWithoutNotifications:^{
        [model addObjects:parser.friends];
    }];
}

@end

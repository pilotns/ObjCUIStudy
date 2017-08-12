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
#import "AMPFBUserPicture.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPFBGetUsersContext ()
@property (nonatomic, readonly) AMPFBUser   *user;

- (AMPFBUser *)userWithResponse:(id)response;

@end

@implementation AMPFBGetUsersContext

@dynamic user;

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return [FBSDKAccessToken currentAccessToken].userID;
}

- (NSDictionary *)parameters {
    return @{@"fields" : @"friends{first_name,last_name,id,picture}"};
}

- (id)model {
    return self.user.friendsModel;
}

#pragma mark -
#pragma mark Public Methods

- (void)parseResponse:(id)response {
    AMPFBResponseParser *parser = [AMPFBResponseParser parserWithResponse:response];
    AMPFBUser *user = self.user;
    
    for (id friend in parser.friends) {
        [user addFriend:[self userWithResponse:friend]];
    }
    
    [user.friendsModel finishLoading];
}

#pragma mark -
#pragma mark Private Methods

- (AMPFBUser *)userWithResponse:(id)response {
    AMPFBResponseParser *parser = [AMPFBResponseParser parserWithResponse:response];
    AMPFBUser *user = [AMPFBUser managedObjectWithUserID:parser.userID];
    
    user.userID = parser.userID;
    user.firstName = parser.firstName;
    user.lastName = parser.lastName;
    user.smallPicture = [AMPFBUserPicture managedObjectWithURLString:parser.pictureURLString];
    
    [user save];
    
    return user;
}

@end

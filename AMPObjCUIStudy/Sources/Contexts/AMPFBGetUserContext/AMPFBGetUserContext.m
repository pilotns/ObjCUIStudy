//
//  AMPFBGetUserContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetUserContext.h"

#import "AMPFBUser.h"
#import "AMPFBUserPicture.h"
#import "AMPFBResponseParser.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPFBGetUserContext ()

@end

@implementation AMPFBGetUserContext

#pragma mark -
#pragma mark Accessors

- (id)model {
    return self.user;
}

- (NSString *)graphPath {
    NSString *fbUserID = self.user.userID;
    
    return fbUserID ? fbUserID : [FBSDKAccessToken currentAccessToken].userID;
}

- (NSDictionary *)parameters {
    return @{@"fields" : @"first_name,last_name,picture.type(large)"};
}

#pragma mark -
#pragma mark Public Methods

- (void)parseResponse:(id)response {
    AMPFBUser *user = self.user;
    AMPFBResponseParser *parser = [AMPFBResponseParser parserWithResponse:response];

    [parser fillUser:user withPictureType:AMPFBUserPictureLarge];
    
    [user save];
}

@end

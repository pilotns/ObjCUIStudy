//
//  AMPFBResponseParser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 31.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBResponseParser.h"

#import "AMPFBUser.h"

static NSString * const kAMPFBParserLargePicture = @"200x200";

static NSString * const kAMPFBUserID = @"id";
static NSString * const kAMPFBUserFirstName = @"first_name";
static NSString * const kAMPFBUserLastName = @"last_name";
static NSString * const kAMPFBUserFriends = @"friends.data";
static NSString * const kAMPFBUserPictureURL = @"picture.data.url";

@interface AMPFBResponseParser ()
@property (nonatomic, strong)   id                  response;

@end

@implementation AMPFBResponseParser

@dynamic userID;
@dynamic firstName;
@dynamic lastName;
@dynamic pictureURLString;
@dynamic friends;


#pragma mark -
#pragma mark Class Methods

+ (instancetype)parserWithResponse:(id)response {
    return [[self alloc] initWithResponse:response];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithResponse:(id)response {
    self = [super init];
    self.response = response;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)userID {
    return [self.response valueForKeyPath:kAMPFBUserID];
}

- (NSString *)firstName {
    return [self.response valueForKeyPath:kAMPFBUserFirstName];
}

- (NSString *)lastName {
    return [self.response valueForKeyPath:kAMPFBUserLastName];
}

- (NSString *)pictureURLString {
    return [self.response valueForKeyPath:kAMPFBUserPictureURL];
}

- (NSArray *)friends {
    return [self.response valueForKeyPath:kAMPFBUserFriends];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillUser:(AMPFBUser *)user withPictureType:(AMPFBUserPictureType)type {
    user.userID = self.userID;
    user.firstName = self.firstName;
    user.lastName = self.lastName;
    
    AMPFBUserPicture *picture = [AMPFBUserPicture managedObjectWithURLString:self.pictureURLString];
    picture.type = type;
    [user addPicture:picture];
    
    [picture save];
}

@end

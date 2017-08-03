//
//  AMPFBResponseParser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 31.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBResponseParser.h"

#import "AMPFBUser.h"
#import "AMPUsersModel.h"

static NSString * const kAMPFBUserID = @"id";
static NSString * const kAMPFBUserFirstName = @"first_name";
static NSString * const kAMPFBUserLastName = @"last_name";
static NSString * const kAMPFBUserFriends = @"friends.data";
static NSString * const kAMPFBUserPictureURL = @"picture.data.url";

@interface AMPFBResponseParser ()
@property (nonatomic, strong)   id          response;

- (AMPFBUser *)userWithResponse:(id)response;

@end

@implementation AMPFBResponseParser

@dynamic userID;
@dynamic firstName;
@dynamic lastName;
@dynamic pictureURL;
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

- (NSURL *)pictureURL {
    return [NSURL URLWithString:[self.response valueForKeyPath:kAMPFBUserPictureURL]];
}

- (NSArray *)friends {
    NSArray *friends = [self.response valueForKeyPath:kAMPFBUserFriends];
    NSUInteger friendsCount = friends.count;
    if (!friendsCount) {
        return nil;
    }
    
    NSMutableArray *mutableFriends = [NSMutableArray arrayWithCapacity:friendsCount];
    for (id friend in friends) {
        [mutableFriends addObject:[self userWithResponse:friend]];
    }
    
    return [mutableFriends copy];
}

#pragma mark -
#pragma mark Private Methods

- (AMPFBUser *)userWithResponse:(id)response {
    AMPFBUser *user = [AMPFBUser new];
    AMPFBResponseParser *parser = [[self class] parserWithResponse:response];
    user.userID = parser.userID;
    user.firstName = parser.firstName;
    user.lastName = parser.lastName;
    user.pictureURL = parser.pictureURL;
    
    [user.friends addObjects:[parser friends]];
    
    return user;
}

@end

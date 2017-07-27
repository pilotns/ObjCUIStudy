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

#import "NSFileManager+AMPExtensions.h"

static NSString * const kAMPFBGetUsersCachedResponseFileName = @"fbUsers.plist";

@implementation AMPFBGetUsersContext

#pragma mark -
#pragma mark Accessors

- (NSString *)cachedResponseFileName {
    return kAMPFBGetUsersCachedResponseFileName;
}

#pragma mark -
#pragma mark Private Methods

- (void)handleResponse:(id)response {
    AMPUsersModel *usersModel = self.model;
    NSArray *friends = response[@"friends"][@"data"];
    NSUInteger friendsCount = friends.count;
    NSMutableArray *mutableFriends = [NSMutableArray arrayWithCapacity:friendsCount];
    for (NSUInteger i = 0; i < friendsCount; i++) {
        NSDictionary *user = friends[i];
        NSDictionary *result = @{kAMPFBUserID : user[@"id"],
                                 kAMPFBUserFirstName : user[@"first_name"],
                                 kAMPFBUserLastName : user[@"last_name"],
                                 kAMPFBUserSmallPictureURL : user[@"picture"][@"data"][@"url"]
                                 };
        
        AMPFBUser *friend = [AMPFBUser new];
        [friend fillWithResponse:result];
        
        [mutableFriends addObject:friend];
    }
    
    [usersModel performBlockWithoutNotifications:^{
        [usersModel addObjects:mutableFriends];
    }];
}

@end

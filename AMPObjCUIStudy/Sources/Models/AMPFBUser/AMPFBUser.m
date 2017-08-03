//
//  AMPFBUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUser.h"

#import "AMPImageModel.h"
#import "AMPUsersModel.h"

@implementation AMPFBUser

@dynamic pictureModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.friends = [AMPUsersModel new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAuthorized {
    return [self.userID isEqualToString:[FBSDKAccessToken currentAccessToken].userID];
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (AMPImageModel *)pictureModel {
    return [AMPImageModel imageModelWithURL:self.pictureURL];
}

@end

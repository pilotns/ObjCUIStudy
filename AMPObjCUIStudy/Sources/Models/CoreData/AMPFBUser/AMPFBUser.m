//
//  AMPFBUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUser.h"

#import "AMPGCDExtensions.h"
#import "AMPFBUserPicture.h"

@interface AMPFBUser ()

- (AMPFBUserPicture *)pictureWithType:(AMPFBUserPictureType)type;

@end

@implementation AMPFBUser

@dynamic userID;

@dynamic firstName;
@dynamic lastName;
@dynamic fullName;
@dynamic friends;

@dynamic pictures;
@dynamic smallPicture;
@dynamic largePicture;

@dynamic friendsModel;

@dynamic authorized;

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (BOOL)isAuthorized {
    return [[FBSDKAccessToken currentAccessToken].userID isEqualToString:self.userID];
}

- (void)setSmallPicture:(AMPFBUserPicture *)smallPicture {
    smallPicture.type = AMPFBUserPictureSmall;
    
    [self addPicture:smallPicture];
}

- (AMPFBUserPicture *)smallPicture {
    return [self pictureWithType:AMPFBUserPictureSmall];
}

- (void)setLargePicture:(AMPFBUserPicture *)largePicture {
    largePicture.type = AMPFBUserPictureLarge;
    
    [self addPicture:largePicture];
}

- (AMPFBUserPicture *)largePicture {
    return [self pictureWithType:AMPFBUserPictureLarge];
}

- (AMPFBFriends *)friendsModel {
    AMPOnce(^{
        return [[AMPFBFriends alloc] initWithUser:self];
    });
}

#pragma mark -
#pragma mark Public Methods

- (void)addFriend:(AMPFBUser *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)removeFriend:(AMPFBUser *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)addPicture:(AMPFBUserPicture *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(pictures))];
}

- (void)removePicture:(AMPFBUserPicture *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(pictures))];
}

#pragma mark -
#pragma mark Private Methods

- (AMPFBUserPicture *)pictureWithType:(AMPFBUserPictureType)type {
    for (AMPFBUserPicture *picture in self.pictures) {
        if (type == picture.type) {
            return picture;
        }
    }
    
    return nil;
}

@end

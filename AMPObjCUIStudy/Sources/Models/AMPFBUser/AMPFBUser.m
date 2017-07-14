//
//  AMPFBUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUser.h"

#import "AMPImageModel.h"

typedef NS_ENUM(NSUInteger, AMPFBUserPictureType) {
    AMPFBUserSmallPicture,
    AMPFBUserLargePicture
};

@interface AMPFBUser ()
@property (nonatomic, copy)     NSString    *fbUserID;
@property (nonatomic, copy)     NSString    *firstName;
@property (nonatomic, copy)     NSString    *lastName;
@property (nonatomic, strong)   NSURL       *smallPictureURL;
@property (nonatomic, strong)   NSURL       *largePictureURL;

- (AMPImageModel *)imageModelWithPictureType:(AMPFBUserPictureType)type;

@end

@implementation AMPFBUser

@dynamic smallPictureImageModel;
@dynamic largePictureImageModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFbUserID:(NSString *)fbUserID {
    self = [super init];
    self.fbUserID = fbUserID;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (AMPImageModel *)smallPictureImageModel {
    return [self imageModelWithPictureType:AMPFBUserSmallPicture];
}

- (AMPImageModel *)largePictureImageModel {
    return [self imageModelWithPictureType:AMPFBUserLargePicture];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResponse:(NSDictionary *)response {
    self.fbUserID = response[kAMPFBUserID];
    self.firstName = response[kAMPFBUserFirstName];
    self.lastName = response[kAMPFBUserLastName];
    self.smallPictureURL = [NSURL URLWithString:response[kAMPFBUserSmallPictureURL]];
    self.largePictureURL = [NSURL URLWithString:response[kAMPFBUserLargePictureURL]];
}

#pragma mark -
#pragma mark Private Methods

- (AMPImageModel *)imageModelWithPictureType:(AMPFBUserPictureType)type {
    NSURL *imageUrl = AMPFBUserSmallPicture == type ? self.smallPictureURL : self.largePictureURL;
    
    return [AMPImageModel imageModelWithURL:imageUrl];
}

@end

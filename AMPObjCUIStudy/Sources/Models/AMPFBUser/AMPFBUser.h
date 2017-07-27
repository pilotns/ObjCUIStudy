//
//  AMPFBUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

static NSString * const kAMPFBUserID = @"kAMPFBUserID";
static NSString * const kAMPFBUserFirstName = @"kAMPFBUserFirstName";
static NSString * const kAMPFBUserLastName = @"kAMPFBUserLastName";
static NSString * const kAMPFBUserSmallPictureURL = @"kAMPFBUserSmallPictureURL";
static NSString * const kAMPFBUserLargePictureURL = @"kAMPFBUserLargePictureURL";

@class AMPImageModel;

@interface AMPFBUser : AMPModel <NSCoding>
@property (nonatomic, readonly) NSString        *fbUserID;
@property (nonatomic, readonly) NSString        *firstName;
@property (nonatomic, readonly) NSString        *lastName;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) AMPImageModel   *smallPictureImageModel;
@property (nonatomic, readonly) AMPImageModel   *largePictureImageModel;

- (instancetype)initWithFbUserID:(NSString *)fbUserID;

- (void)fillWithResponse:(NSDictionary *)response;

@end

//
//  AMPFBUserPicture.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPManagedObject.h"

@class AMPFBUser;
@class AMPImageModel;

typedef NS_ENUM(NSUInteger, AMPFBUserPictureType) {
    AMPFBUserPictureSmall,
    AMPFBUserPictureLarge
};

@interface AMPFBUserPicture : AMPManagedObject
@property (nonatomic, assign)   NSUInteger  type;
@property (nonatomic, copy)     NSString    *urlString;
@property (nonatomic, strong)   AMPFBUser   *user;

@property (nonatomic, readonly) AMPImageModel   *imageModel;

+ (instancetype)managedObjectWithURLString:(NSString *)string;

@end

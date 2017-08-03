//
//  AMPDBUserPicture.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPDBUser;

typedef NS_ENUM(NSUInteger, AMPDBUserPictureType) {
    AMPDBUserPictureSmall,
    AMPDBUserPictureLarge
};

@interface AMPDBUserPicture : NSManagedObject
@property (nonatomic, assign)   NSUInteger  type;
@property (nonatomic, copy)     NSString    *urlString;
@property (nonatomic, strong)   AMPDBUser   *user;

@end

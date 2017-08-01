//
//  AMPFBUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

@class AMPImageModel;
@class AMPFBResponseParser;
@class AMPUsersModel;

@interface AMPFBUser : AMPModel
@property (nonatomic, copy)     NSString        *userID;
@property (nonatomic, copy)     NSString        *firstName;
@property (nonatomic, copy)     NSString        *lastName;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, strong)   NSURL           *pictureURL;
@property (nonatomic, readonly) AMPImageModel   *pictureModel;
@property (nonatomic, strong)   AMPUsersModel   *friends;

@property (nonatomic, readonly) BOOL    isAuthorized;

@end

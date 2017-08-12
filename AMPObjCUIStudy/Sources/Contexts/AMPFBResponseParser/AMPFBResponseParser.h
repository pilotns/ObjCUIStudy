//
//  AMPFBResponseParser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 31.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPFBUserPicture.h"

@class AMPFBUser;

@interface AMPFBResponseParser : NSObject
@property (nonatomic, readonly) NSString    *userID;
@property (nonatomic, readonly) NSString    *firstName;
@property (nonatomic, readonly) NSString    *lastName;

@property (nonatomic, readonly) NSString    *pictureURLString;
@property (nonatomic, readonly) NSArray     *friends;

+ (instancetype)parserWithResponse:(id)response;

- (void)fillUser:(AMPFBUser *)user withPictureType:(AMPFBUserPictureType)type;

@end

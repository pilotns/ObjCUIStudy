//
//  AMPFBResponseParser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 31.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPFBUser;

@interface AMPFBResponseParser : NSObject
@property (nonatomic, readonly) NSString    *userID;
@property (nonatomic, readonly) NSString    *firstName;
@property (nonatomic, readonly) NSString    *lastName;
@property (nonatomic, readonly) NSURL       *pictureURL;
@property (nonatomic, readonly) NSArray     *friends;

+ (instancetype)parserWithResponse:(id)response;

- (instancetype)initWithResponse:(id)response;

@end

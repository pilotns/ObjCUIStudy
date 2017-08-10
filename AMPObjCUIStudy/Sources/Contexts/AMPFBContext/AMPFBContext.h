//
//  AMPFBContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 10.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPContext.h"

@class AMPFBUser;
@class AMPFBViewController;

@interface AMPFBContext : AMPContext
@property (nonatomic, readonly)         AMPFBUser           *user;
@property (nonatomic, weak, readonly)   AMPFBViewController *viewController;

@property (nonatomic, readonly) NSString    *authorizedUserID;

- (instancetype)initWithUser:(AMPFBUser *)user viewController:(AMPFBViewController *)viewController;

@end

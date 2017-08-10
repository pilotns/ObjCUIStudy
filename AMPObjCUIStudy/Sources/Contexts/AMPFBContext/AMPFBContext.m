//
//  AMPFBContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 10.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBContext.h"

#import "AMPModel.h"

@interface AMPFBContext ()
@property (nonatomic, strong)   AMPFBUser           *user;
@property (nonatomic, weak)     AMPFBViewController *viewController;

@end

@implementation AMPFBContext

@dynamic authorizedUserID;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(AMPFBUser *)user viewController:(AMPFBViewController *)viewController {
    self = [super init];
    self.user = user;
    self.viewController = viewController;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)authorizedUserID {
    return [FBSDKAccessToken currentAccessToken].userID;
}

@end

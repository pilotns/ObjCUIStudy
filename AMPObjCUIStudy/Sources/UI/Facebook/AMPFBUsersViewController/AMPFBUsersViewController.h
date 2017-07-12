//
//  AMPFBUsersViewController.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPUsersModel;
@class AMPFBGetUsersContext;

@interface AMPFBUsersViewController : UIViewController
@property (nonatomic, strong)   AMPUsersModel           *usersModel;
@property (nonatomic, strong)   AMPFBGetUsersContext    *context;

@end

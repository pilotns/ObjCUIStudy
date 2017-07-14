//
//  AMPFBUserViewController.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPFBUser;
@class AMPFBGetUserContext;

@interface AMPFBUserViewController : UIViewController
@property (nonatomic, strong)   AMPFBUser           *user;

- (IBAction)onFriendsButton:(id)sender;

@end

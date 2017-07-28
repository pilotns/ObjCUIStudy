//
//  AMPFBUserView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBView.h"

@class AMPImageView;
@class AMPFBUser;

@interface AMPFBUserView : AMPFBView
@property (nonatomic, strong)   IBOutlet    AMPImageView    *userImageView;
@property (nonatomic, strong)   IBOutlet    UILabel         *fullNameLable;
@property (nonatomic, strong)   IBOutlet    UIButton        *friendsButton;

- (void)fillWithUser:(AMPFBUser *)user;

@end

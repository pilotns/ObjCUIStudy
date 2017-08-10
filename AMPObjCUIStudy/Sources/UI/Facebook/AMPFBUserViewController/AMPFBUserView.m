//
//  AMPFBUserView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUserView.h"

#import "AMPImageView.h"
#import "AMPFBUser.h"
#import "AMPFBUserPicture.h"

@implementation AMPFBUserView

#pragma mark -
#pragma mark Public Methods

- (void)fillWithUser:(AMPFBUser *)user {
    self.fullNameLable.text = user.fullName;
    self.userImageView.imageModel = user.largePicture.imageModel;
}

@end

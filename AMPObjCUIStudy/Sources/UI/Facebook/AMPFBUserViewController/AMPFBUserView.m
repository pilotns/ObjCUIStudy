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

@implementation AMPFBUserView

#pragma mark -
#pragma mark Public Methods

- (void)fillWithUser:(AMPFBUser *)user {
    self.userImageView.imageModel = user.pictureModel;
    self.fullNameLable.text = user.fullName;
}

@end

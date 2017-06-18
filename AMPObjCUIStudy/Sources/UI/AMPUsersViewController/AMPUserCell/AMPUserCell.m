//
//  AMPUserCell.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUserCell.h"

#import "AMPUser.h"

@interface AMPUserCell ()

- (void)fillWithUser:(AMPUser *)user;

@end

@implementation AMPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AMPUser *)user {
    if (_user != user) {
        _user = user;
    }
    
    [self fillWithUser:user];
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithUser:(AMPUser *)user {
    self.fullNameLable.text = user.fullName;
    self.userImageView.image = user.image;
}

@end

//
//  AMPUserCell.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUserCell.h"

#import "AMPFBUser.h"
#import "AMPImageView.h"

@interface AMPUserCell ()

- (void)fillWithUser:(AMPFBUser *)user;

@end

@implementation AMPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AMPFBUser *)user {
    if (_user != user) {
        _user = user;
    }
    
    [self fillWithUser:user];
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithUser:(AMPFBUser *)user {
    self.fullNameLabel.text = user.fullName;
    self.userImageView.imageModel = user.pictureModel;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.user = nil;
    self.userImageView.contentImageView.image = nil;
}

@end

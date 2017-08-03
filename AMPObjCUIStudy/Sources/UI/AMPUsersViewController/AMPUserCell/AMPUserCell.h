//
//  AMPUserCell.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTableViewCell.h"

@class AMPFBUser;
@class AMPImageView;

@interface AMPUserCell : AMPTableViewCell
@property (nonatomic, strong)   IBOutlet    UILabel         *fullNameLabel;
@property (nonatomic, strong)   IBOutlet    AMPImageView    *userImageView;

@property (nonatomic, strong)   AMPFBUser *user;

@end

//
//  AMPUserCell.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTableViewCell.h"

@class AMPUser;

@interface AMPUserCell : AMPTableViewCell
@property (nonatomic, strong)   IBOutlet    UILabel     *fullNameLable;
@property (nonatomic, strong)   IBOutlet    UIImageView *userImageView;

@property (nonatomic, strong)   AMPUser *user;

@end

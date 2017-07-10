//
//  AMPTableViewCell.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTableViewCell.h"

@implementation AMPTableViewCell

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end

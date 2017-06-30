//
//  AMPUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPImageModel;

@interface AMPUser : NSObject <NSCoding>
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) AMPImageModel   *imageModel;

@end

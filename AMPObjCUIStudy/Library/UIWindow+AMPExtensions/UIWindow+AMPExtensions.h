//
//  UIWindow+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (AMPExtensions)

+ (instancetype)windowForMainScreen;
+ (instancetype)windowForMainScreenWithRootViewController:(UIViewController *)controller;

@end

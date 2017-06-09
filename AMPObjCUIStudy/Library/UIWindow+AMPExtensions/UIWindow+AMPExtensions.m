//
//  UIWindow+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "UIWindow+AMPExtensions.h"

@implementation UIWindow (AMPExtensions)

+ (instancetype)windowForMainScreen {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

+ (instancetype)windowForMainScreenWithRootViewController:(UIViewController *)controller {
    UIWindow *window = [self windowForMainScreen];
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    
    return window;
}

@end

//
//  UIWindow+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "UIWindow+AMPExtensions.h"

@implementation UIWindow (AMPExtensions)

+ (instancetype)window {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

+ (instancetype)windowWithRootViewController:(UIViewController *)controller {
    UIWindow *window = [self window];
    window.rootViewController = controller;
    
    return window;
}

@end

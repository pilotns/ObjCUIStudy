//
//  AMPAppDelegate.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAppDelegate.h"

#import "AMPViewController.h"

#import "UIWindow+AMPExtensions.h"

@interface AMPAppDelegate ()

@end

@implementation AMPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AMPViewController *controller = [AMPViewController new];
    self.window = [UIWindow windowForMainScreenWithRootViewController:controller];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end

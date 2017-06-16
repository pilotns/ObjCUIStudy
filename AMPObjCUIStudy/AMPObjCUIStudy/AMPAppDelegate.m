//
//  AMPAppDelegate.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAppDelegate.h"

#import "AMPUsersViewController.h"
#import "AMPUsersModel.h"

#import "UIWindow+AMPExtensions.h"

@interface AMPAppDelegate ()

@end

@implementation AMPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AMPUsersViewController *controller = [AMPUsersViewController new];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window = [UIWindow windowWithRootViewController:navController];
    
    controller.users = [AMPUsersModel new];
    
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

//
//  AMPAppDelegate.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAppDelegate.h"

#import "AMPUsersViewController.h"
#import "AMPArrayModel.h"
#import "AMPUser.h"

#import "UIWindow+AMPExtensions.h"
#import "NSObject+AMPExtensions.h"

static const NSUInteger AMPDefaultUsersCount = 25;

@interface AMPAppDelegate ()

@end

@implementation AMPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AMPUsersViewController *controller = [AMPUsersViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    UIWindow *window = [UIWindow windowWithRootViewController:navController];
    self.window = window;
    
    [window makeKeyAndVisible];
    
    controller.users = [[AMPArrayModel alloc] initWithObjects:[AMPUser objectsWithCount:AMPDefaultUsersCount]];
    
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

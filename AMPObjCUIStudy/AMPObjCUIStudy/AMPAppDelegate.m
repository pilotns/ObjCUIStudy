//
//  AMPAppDelegate.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAppDelegate.h"

#import "AMPFBLoginViewController.h"

#import "UIWindow+AMPExtensions.h"
#import "NSObject+AMPExtensions.h"

static NSString * const AMPMomName = @"FacebookDataModel";

@interface AMPAppDelegate ()

@end

@implementation AMPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [IDPCoreDataManager sharedManagerWithMomName:AMPMomName];
    
    AMPFBLoginViewController *controller = [AMPFBLoginViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    UIWindow *window = [UIWindow windowWithRootViewController:navController];
    self.window = window;
    
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [NSManagedObjectContext saveManagedObjectContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
    [NSManagedObjectContext saveManagedObjectContext];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}


@end

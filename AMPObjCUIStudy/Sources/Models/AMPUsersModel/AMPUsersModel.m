//
//  AMPUsersModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 26.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AMPUsersModel.h"
#import "AMPUser.h"

#import "NSObject+AMPExtensions.h"
#import "AMPArrayModel+AMPPrivate.h"
#import "NSNotificationCenter+AMPExtensions.h"
#import "NSFileManager+AMPExtensions.h"

static NSString * const kAMPDefaultPathComponent    = @"users.plist";
static NSUInteger const kAMPDefaultUsersCount       = 10;

@interface AMPUsersModel ()
@property (nonatomic, strong)   NSArray         *notificationTokens;

- (void)save;

- (NSString *)objectsPath;
- (void)prepareObservation;

@end

@implementation AMPUsersModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    [self prepareObservation];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoading {
    usleep(1000 * 1000 * 3);
    NSArray *objects = [NSKeyedUnarchiver unarchiveObjectWithFile:[self objectsPath]];
    if (!objects) {
        objects = [AMPUser objectsWithCount:kAMPDefaultUsersCount];
    }
    
    [self performBlockWithoutNotifications:^{
        [self addObjects:objects];
        
        [self performBlockWithNotifications:^{
            self.state = AMPModelDidLoad;
        }];
    }];
}

#pragma mark -
#pragma mark Private Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.allObjects toFile:[self objectsPath]];
}

- (NSString *)objectsPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [[manager URLForDocumentsDirectory] URLByAppendingPathComponent:kAMPDefaultPathComponent];
    
    return url.path;
}

- (void)prepareObservation {
    NSArray *notificationKeys = @[UIApplicationWillTerminateNotification,
                                  UIApplicationWillResignActiveNotification];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSArray *tokens = [center observerTokensForNames:notificationKeys
                                          usingBlock:^(NSNotification *note) {
                                              [self save];
                                          }];
    
    self.notificationTokens = tokens;
}

@end

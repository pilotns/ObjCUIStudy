//
//  AMPUsersModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 26.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AMPUsersModel.h"

#import "AMPArrayModel+AMPPrivate.h"
#import "NSNotificationCenter+AMPExtensions.h"

static NSString * const kAMPDefaultPathComponent = @"Users.plist";

@interface AMPUsersModel ()
@property (nonatomic, strong)   NSArray         *notificationTokens;

- (void)save;

- (NSString *)objectsPath;
- (void)prepareObservation;

@end

@implementation AMPUsersModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObservers:self.notificationTokens];
}

- (instancetype)init {
    self = [super init];
    [self prepareObservation];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoading {
    usleep(1000 * 1000 * 3);
    NSMutableArray *objects = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self objectsPath]] mutableCopy];
    if (!objects) {
        objects = [NSMutableArray array];
    }
    
    self.mutableObjects = objects;
}

#pragma mark -
#pragma mark Private Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.mutableObjects toFile:[self objectsPath]];
}

- (NSString *)objectsPath {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *url = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    return [url URLByAppendingPathComponent:kAMPDefaultPathComponent].path;
}

- (void)prepareObservation {
    NSArray *notificationKeys = @[UIApplicationWillTerminateNotification,
                                  UIApplicationWillResignActiveNotification];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSArray *tokens = [center addObserverForNames:notificationKeys
                                       usingBlock:^(NSNotification *note) {
                                           [self save];
                                       }];
    
    self.notificationTokens = tokens;
}

@end

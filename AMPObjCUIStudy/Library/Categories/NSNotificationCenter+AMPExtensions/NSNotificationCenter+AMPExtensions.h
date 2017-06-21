//
//  NSNotificationCenter+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (AMPExtensions)

- (NSArray *)addObserverForNames:(NSArray *)names usingBlock:(void (^)(NSNotification *note))block;

- (NSArray *)addObserverForNames:(NSArray *)names
                          object:(id)obj
                           queue:(NSOperationQueue *)queue
                      usingBlock:(void (^)(NSNotification *note))block;

- (void)removeObservers:(NSArray *)observers;

@end

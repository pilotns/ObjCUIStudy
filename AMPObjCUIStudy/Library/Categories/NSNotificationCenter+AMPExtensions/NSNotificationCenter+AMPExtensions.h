//
//  NSNotificationCenter+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (AMPExtensions)

- (NSArray *)observerTokensForNames:(NSArray *)names usingBlock:(void (^)(NSNotification *note))block;

- (NSArray *)observerTokensForNames:(NSArray *)names
                          object:(id)obj
                           queue:(NSOperationQueue *)queue
                      usingBlock:(void (^)(NSNotification *note))block;

- (void)removeObserverTokens:(NSArray *)tokens;

@end

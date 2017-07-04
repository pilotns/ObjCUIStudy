//
//  NSNotificationCenter+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSNotificationCenter+AMPExtensions.h"

@implementation NSNotificationCenter (AMPExtensions)

- (NSArray *)addObserverForNames:(NSArray *)names usingBlock:(void (^)(NSNotification *note))block {
    return [self addObserverForNames:names object:nil queue:[NSOperationQueue mainQueue] usingBlock:block];
}

- (NSArray *)addObserverForNames:(NSArray *)names
                          object:(id)obj
                           queue:(NSOperationQueue *)queue
                      usingBlock:(void (^)(NSNotification *note))block
{
    if (!block) {
        return nil;
    }
    
    NSMutableArray *tokens = [NSMutableArray arrayWithCapacity:names.count];
    for (NSString *name in names) {
        id token = [self addObserverForName:name object:obj queue:queue usingBlock:block];
        [tokens addObject:token];
    }
    
    return [tokens copy];
}

- (void)removeObserverTokens:(NSArray *)tokens {
    for (id token in tokens) {
        [self removeObserver:token];
    }
}

@end

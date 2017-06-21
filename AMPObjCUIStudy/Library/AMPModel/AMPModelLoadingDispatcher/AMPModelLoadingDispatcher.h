//
//  AMPModelLoadingDispatcher.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPModelLoadingDispatcher : NSObject

+ (instancetype)sharedDispatcher;

- (void)addOperation:(NSOperation *)operation;

@end

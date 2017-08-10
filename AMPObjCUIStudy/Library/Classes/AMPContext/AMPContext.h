//
//  AMPContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AMPContextCompletionHandler)(NSUInteger modelState, NSError *error);

@interface AMPContext : NSObject
@property (nonatomic, readonly) id  model;

- (void)execute;
- (void)cancel;

// this method is intended for subclassing, do not call it directly
// subclasses must call completionHandler after execution finished
- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler;

@end

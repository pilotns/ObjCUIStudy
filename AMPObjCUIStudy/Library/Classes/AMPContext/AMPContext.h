//
//  AMPContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AMPContextCompletionHandler)(NSUInteger modelState, NSError *error);

@class AMPModel;

@interface AMPContext : NSObject
@property (nonatomic, readonly) id  model;

- (instancetype)initWithModel:(AMPModel *)model;

- (void)execute;
- (void)cancel;

// this method is intebded for subclassing, do not call it directly,
// subclasses must call completionHandler after context finish executing
- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler;

@end

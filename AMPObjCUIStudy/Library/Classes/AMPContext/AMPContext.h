//
//  AMPContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPContextState) {
    AMPContextDidFinishExecuting,
    AMPContextStateCount
};

@class AMPContext;
@class AMPModel;

@protocol AMPContextObserver <NSObject>

@optional
- (void)context:(AMPContext *)context didFinishExecutingWithError:(NSError *)error;

@end

@interface AMPContext : AMPObservableObject
@property (nonatomic, weak, readonly) id    model;

- (instancetype)initWithModel:(AMPModel *)model;

- (void)execute;
- (void)cancel;

// this method is intebded for subclassing, do not call it directly,
// subclasses must call completionHandler after context finish executing
- (void)performExecutionWithCompletionHandler:(void (^)(NSError *error))completionHandler;

@end

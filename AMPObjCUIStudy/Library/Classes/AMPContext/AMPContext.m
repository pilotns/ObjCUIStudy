//
//  AMPContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPContext.h"

#import "AMPModel.h"

#import "AMPMacro.h"

@implementation AMPContext

@dynamic model;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    AMPWeakify(self);
    [self performExecutionWithCompletionHandler:^(NSUInteger modelState, NSError *error) {
        AMPStrongifyAndReturnIfNil(self);
        [self.model setState:modelState userInfo:error];
        [self.model save];
    }];
}

- (void)cancel {

}

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    
}

@end

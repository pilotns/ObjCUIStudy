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

@interface AMPContext ()
@property (nonatomic, strong) AMPModel    *model;

@end

@implementation AMPContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithModel:(AMPModel *)model {
    self = [super init];
    self.model = model;
    
    return self;
}

- (void)execute {
    AMPWeakify(self);
    [self performExecutionWithCompletionHandler:^(NSUInteger modelState, NSError *error) {
        AMPStrongifyAndReturnIfNil(self);
        [self.model setState:modelState userInfo:error];
    }];
}

- (void)cancel {

}

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    
}

@end

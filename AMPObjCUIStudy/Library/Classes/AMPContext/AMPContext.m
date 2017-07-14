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
@property (nonatomic, weak) AMPModel    *model;

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
    AMPModel *model = self.model;
    AMPModelState state = model.state;
    
    @synchronized (model) {
        if (AMPModelWillLoad == state || AMPModelDidLoad == state) {
            [model notifyOfState:state];
            return;
        }
        
        model.state = AMPModelWillLoad;
    }
    
    AMPWeakify(self);
    [self performExecutionWithCompletionHandler:^(NSError *error) {
        AMPStrongifyAndReturnIfNil(self);
        [self notifyOfState:AMPContextDidFinishExecuting userInfo:error];
        model.state = AMPModelDidLoad;
    }];
}

- (void)cancel {

}

- (void)performExecutionWithCompletionHandler:(void (^)(NSError *error))completionHandler {
    
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    return AMPContextDidFinishExecuting == state
        ? @selector(context:didFinishExecutingWithError:)
        : [super selectorForState:state];
}

@end

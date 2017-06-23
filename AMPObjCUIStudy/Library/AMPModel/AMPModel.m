//
//  AMPModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel+AMPPrivate.h"

#import "AMPMarcos.h"
#import "AMPModelLoadingDispatcher.h"
#import "AMPGCDExtensions.h"

@interface AMPModel ()
@property (nonatomic, readonly)   NSOperation *operation;

- (NSOperation *)loadingOperation;

@end

@implementation AMPModel

@dynamic loaded;

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        if (operation) {
            [[AMPModelLoadingDispatcher sharedDispatcher] addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized (self) {
        if (AMPModelLoading == self.state) {
            return;
        }
        
        if (AMPModelLoaded == self.state) {
            [self notifyOfState:AMPModelLoaded];
            return;
        }
    
        self.state = AMPModelLoading;
    }
    
    self.operation = [self loadingOperation];
}

- (void)save {
    [self processSave];
}

- (void)dump {
    [self processDump];
}

#pragma mark -
#pragma mark Private Methods

- (NSOperation *)loadingOperation {
    AMPWeakify(self);
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        AMPStrongifyAndReturnIfNil(self);
        [self processLoad];
    }];
    
    operation.completionBlock = ^{
        AMPDispatchAsyncOnMainQueue(^{
            AMPStrongifyAndReturnIfNil(self);
            self.state = self.isLoaded ? AMPModelLoaded : AMPModelFailLoaded;
        });
    };
    
    return operation;
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AMPModelLoading:
            return @selector(modelDidBecomeLoading:);
        case AMPModelLoaded:
            return @selector(modelDidFinishLoading:);
        case AMPModelFailLoaded:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end

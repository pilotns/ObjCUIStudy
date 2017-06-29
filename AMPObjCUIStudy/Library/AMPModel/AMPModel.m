//
//  AMPModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

#import "AMPMarcos.h"
#import "AMPGCDExtensions.h"

@interface AMPModel ()

- (void)processLoadingInBackground;

@end

@implementation AMPModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AMPModelWillLoad == state || AMPModelDidLoad == state) {
            [self notifyOfState:state];
            return;
        }
    
        self.state = AMPModelWillLoad;
    }
    
    [self processLoadingInBackground];
}

- (void)processLoading {
    
}

- (void)finishLoading {
    
}

#pragma mark -
#pragma mark Private Methods

- (void)processLoadingInBackground {
    AMPWeakify(self);
    AMPDispatchAsyncInBackground(^{
        AMPStrongifyAndReturnIfNil(self);
        [self processLoading];
        
        AMPDispatchAsyncOnMainQueue(^{
            AMPStrongifyAndReturnIfNil(self);
            [self finishLoading];
        });
    });
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AMPModelDidUnload:
            return @selector(modelDidUnload:);
        case AMPModelWillLoad:
            return @selector(modelWillLoad:);
        case AMPModelDidLoad:
            return @selector(modelDidLoad:);
        case AMPModelDidFailLoading:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end

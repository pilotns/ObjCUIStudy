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

static char * const kAMPModeObservationContext = "kAMPModeObservationContext";

@interface AMPModel ()

- (void)prepareKeyValueObserving;
- (void)processLoadingInBackground;

@end

@implementation AMPModel

@dynamic propertyKeyPath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self removeObserver:self forKeyPath:self.propertyKeyPath context:kAMPModeObservationContext];
}

- (instancetype)init {
    self = [super init];
    [self prepareKeyValueObserving];
    
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

#pragma mark -
#pragma mark Private Methods

- (void)prepareKeyValueObserving {
    [self addObserver:self
           forKeyPath:self.propertyKeyPath
              options:NSKeyValueObservingOptionNew
              context:kAMPModeObservationContext];
}

- (void)processLoadingInBackground {
    AMPWeakify(self);
    AMPDispatchAsyncInBackground(^{
        AMPStrongifyAndReturnIfNil(self);
        [self processLoading];
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

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    self.state = change[NSKeyValueChangeNewKey] ? AMPModelDidLoad : AMPModelDidFailLoading;
}

@end

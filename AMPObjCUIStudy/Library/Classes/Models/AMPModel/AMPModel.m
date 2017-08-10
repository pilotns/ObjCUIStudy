//
//  AMPModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

@interface AMPModel ()
@property (nonatomic, weak) id  target;

@end

@implementation AMPModel

@synthesize target = _target;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    self.target = target;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (id)target {
    id target = _target;
    
    return target ? target : self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    
}

#pragma mark -
#pragma mark AMPModel

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AMPModelWillLoad == state || AMPModelDidLoad == state) {
            [self notifyOfState:state];
            return;
        }
    
        self.state = AMPModelWillLoad;
    }
    
    [self performLoading];
}

- (void)save {
    
}

- (void)clear {
    
}

- (void)cancel {
    @synchronized (self) {
        if (AMPModelWillLoad != self.state) {
            return;
        }
        
        [self clear];
        self.state = AMPModelDidUnload;
    }
}

- (void)finishLoading {
    @synchronized (self) {
        self.state = AMPModelDidLoad;
    }
}

- (void)failLoading {
    @synchronized (self) {
        self.state = AMPModelDidFailLoading;
    }
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

//
//  AMPModelLoadingDispatcher.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModelLoadingDispatcher.h"

static const NSInteger kAMPModelLoadingDispatcherMaxConcurentOperationCount = 1;

@interface AMPModelLoadingDispatcher ()
@property (nonatomic, strong)   NSOperationQueue    *queue;

@end

@implementation AMPModelLoadingDispatcher

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedDispatcher {
    static AMPModelLoadingDispatcher *sharedDispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDispatcher = [[self alloc] init];
    });
    
    return sharedDispatcher;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    self.queue = [NSOperationQueue new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        queue.maxConcurrentOperationCount = kAMPModelLoadingDispatcherMaxConcurentOperationCount;

        _queue = queue;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addOperation:(NSOperation *)operation {
    [self.queue addOperation:operation];
}

@end

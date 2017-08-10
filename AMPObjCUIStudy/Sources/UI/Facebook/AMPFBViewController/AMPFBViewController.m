//
//  AMPFBViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 18.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBViewController.h"

#import "AMPFBUser.h"
#import "AMPView.h"
#import "AMPModel.h"
#import "AMPContext.h"

#import "AMPGCDExtensions.h"
#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBViewController, AMPView, rootView);

@interface AMPFBViewController () <AMPModelObserver>

@end

@implementation AMPFBViewController

#pragma mark -
#pragma mark Initializationa and Deallocations

- (void)dealloc {
    self.model = nil;
    self.context = nil;
}

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAuthorized {
    return nil != [FBSDKAccessToken currentAccessToken];
}

- (void)setModel:(AMPModel *)model {
    if (_model != model) {
        [_model removeListener:self];
        
        _model = model;
        [model addListener:self];
    }
}

- (void)setContext:(AMPContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.rootView setLoadingViewVisible:NO];
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(id)model {
    
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelDidUnload:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        self.context = nil;
        self.model = nil;
    });
}

- (void)modelWillLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self.rootView setLoadingViewVisible:YES];
    });
}

- (void)modelDidLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        self.context = nil;
        [self fillWithModel:model];
        [self.rootView setLoadingViewVisible:NO];
    });
}

@end

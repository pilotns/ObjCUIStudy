//
//  AMPFBViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 18.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBViewController.h"

#import "AMPView.h"
#import "AMPModel.h"
#import "AMPContext.h"

#import "AMPGCDExtensions.h"
#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBViewController, AMPView, rootView);

@interface AMPFBViewController () <AMPModelObserver, AMPContextObserver>

@end

@implementation AMPFBViewController

#pragma mark -
#pragma mark Initializationa and Deallocations

- (void)dealloc {
    self.model = nil;
    self.context = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(AMPModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        [model addObserver:self];
    }
}

- (void)setContext:(AMPContext *)context {
    if (_context != context) {
        [_context cancel];
        [_context removeObserver:self];
        
        _context = context;
        [context addObserver:self];
        [context execute];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(id)model {
    
}

#pragma mark -
#pragma mark AMPModelObserver

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
        [self fillWithModel:model];
        [self.rootView setLoadingViewVisible:NO];
    });
}

@end

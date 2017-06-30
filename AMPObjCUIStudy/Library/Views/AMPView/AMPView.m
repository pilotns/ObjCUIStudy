//
//  AMPView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 27.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPView.h"

#import "AMPLoadingView.h"
#import "AMPGCDExtensions.h"

#import "AMPMarcos.h"

@implementation AMPView

@synthesize loadingView = _loadingView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loadingView = nil;
}

#pragma mark-
#pragma mark Accessors

- (void)setLoadingView:(AMPLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        [self addSubview:loadingView];
    }
}

- (AMPLoadingView *)loadingView {
    if (!_loadingView) {
        self.loadingView = [AMPLoadingView loadingViewInView:self];
    }
    
    return _loadingView;
}

@end

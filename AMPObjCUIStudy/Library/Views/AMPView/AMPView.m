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

#import "AMPMacro.h"

@implementation AMPView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loadingView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.loadingView = [self customLoadingView];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.loadingView = [self customLoadingView];
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

#pragma mark -
#pragma mark Public Methods

- (void)setLoadingViewVisible {
    [self setLoadingViewVisibleAnimated:YES];
}

- (void)setLoadingViewVisibleAnimated:(BOOL)animated {
    [self setLoadingViewVisibleAnimated:animated completionHandler:nil];
}

- (void)setLoadingViewVisibleAnimated:(BOOL)animated completionHandler:(void (^)(void))handler {
    [self.loadingView setState:AMPLoadingViewVisible animated:animated completionHandler:handler];
}

- (void)setLoadingViewHidden {
    [self setLoadingViewHiddenAnimated:YES];
}

- (void)setLoadingViewHiddenAnimated:(BOOL)animated {
    [self setLoadingViewHiddenAnimated:animated completionHandler:nil];
}

- (void)setLoadingViewHiddenAnimated:(BOOL)animated completionHandler:(void (^)(void))handler {
    [self.loadingView setState:AMPLoadingViewHidden animated:YES completionHandler:handler];
}

- (AMPLoadingView *)customLoadingView {
    return [AMPLoadingView loadingViewInView:self];
}

@end

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

@dynamic loadingViewVisible;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loadingView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.loadingView = [self defaultLoadingView];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        self.loadingView = [self defaultLoadingView];
    }
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

- (BOOL)isLoadingViewVisible {
    return AMPLoadingViewVisible == self.loadingView.state;
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible {
    [self setLoadingViewVisible:loadingViewVisible animated:YES];
}

- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated {
    [self setLoadingViewVisible:yesOrNo animated:animated completionHandler:nil];
}

- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated completionHandler:(void (^)(void))handler {
    AMPLoadingViewState state = yesOrNo ? AMPLoadingViewVisible : AMPLoadingViewHidden;
    
    [self.loadingView setState:state animated:animated completionHandler:handler];
}

#pragma mark -
#pragma mark Public Methods

- (AMPLoadingView *)defaultLoadingView {
    return [AMPLoadingView loadingViewInView:self];
}

@end

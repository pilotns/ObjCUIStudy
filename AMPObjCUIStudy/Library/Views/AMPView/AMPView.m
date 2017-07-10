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

#pragma mark -
#pragma mark Public Methods

- (void)setLoadingViewVisible:(BOOL)yesOrNo {
    [self setLoadingViewVisible:yesOrNo animated:YES];
}

- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated {
    [self setLoadingViewVisible:yesOrNo animated:animated completionHandler:nil];
}

- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated completionHandler:(void (^)(void))handler {
    AMPLoadingViewState state = yesOrNo ? AMPLoadingViewVisible : AMPLoadingViewHidden;
    
    [self.loadingView setState:state animated:animated completionHandler:handler];
}

- (AMPLoadingView *)defaultLoadingView {
    return [AMPLoadingView loadingViewInView:self];
}

@end

//
//  AMPLoadingView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLoadingView.h"

#import "UINib+AMPExtensions.h"

static const NSTimeInterval AMPLoadingViewPresentationDuration = 0.25;

@implementation AMPLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewWithView:(UIView *)view {
    return [[self alloc] initWithView:view];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.view = nil;
}

- (instancetype)initWithView:(UIView *)view {
    self = [UINib objectWithClass:[self class]];
    self.view = view;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setView:(UIView *)view {
    if (_view != view) {
        [self removeFromSuperview];
        _view = view;
        
        self.frame = view.frame;
        [_view addSubview:self];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)present {
    [UIView animateWithDuration:AMPLoadingViewPresentationDuration animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.indicator startAnimating];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:AMPLoadingViewPresentationDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.indicator stopAnimating];
    }];
}

@end

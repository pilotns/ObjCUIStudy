//
//  AMPLoadingView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLoadingView.h"

#import "AMPGCDExtensions.h"
#import "AMPMacro.h"

#import "UINib+AMPExtensions.h"

static const NSTimeInterval AMPLoadingViewPresentationDuration = 0.3;

static const CGFloat    AMPLoadingViewPresentedAlpha    = 1;
static const CGFloat    AMPLoadingViewOpacity           = 0.8;

@interface AMPLoadingView ()

- (CGFloat)alphaForState:(AMPLoadingViewState)state;

- (void)baseInit;
- (void)prepareIndicator;

@end

@implementation AMPLoadingView

@synthesize state = _state;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewInView:(UIView *)view {
    return [[self alloc] initWithFrame:view.bounds];
}

#pragma mark -
#pragma mark Initializations and Deallocation

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self baseInit];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self baseInit];
}

#pragma mark -
#pragma mark - Accessors

- (void)setIndicator:(UIActivityIndicatorView *)indicator {
    if (_indicator != indicator) {
        [_indicator removeFromSuperview];
        
        _indicator = indicator;
        [self addSubview:indicator];
    }
}

- (void)setState:(AMPLoadingViewState)state {
    [self setState:state animated:YES];
}

- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated {
    [self setState:state animated:animated completionHandler:nil];
}

- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated completionHandler:(void (^)(void))handler {
    [UIView animateWithDuration:animated ? AMPLoadingViewPresentationDuration : 0
                     animations:^{
                         self.alpha = [self alphaForState:state];
                     } completion:^(BOOL finished) {
                         _state = state;
                         if (handler) {
                             handler();
                         }
                     }];
}

#pragma mark -
#pragma mark Private Methods

- (CGFloat)alphaForState:(AMPLoadingViewState)state {
    return AMPLoadingViewVisible == state ? AMPLoadingViewPresentedAlpha : 0;
}

- (void)baseInit {
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:AMPLoadingViewOpacity];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self prepareIndicator];
}

- (void)prepareIndicator {
    UIActivityIndicatorView *indicator = self.indicator;
    if (indicator) {
        return;
    }
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = AMPCGRectCenter(self.bounds);

    indicator.autoresizingMask = AMPUIViewAutoresizingAll;
    [indicator startAnimating];
    
    self.indicator = indicator;
}

@end

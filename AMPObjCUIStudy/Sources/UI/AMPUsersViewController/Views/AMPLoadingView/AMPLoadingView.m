//
//  AMPLoadingView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLoadingView.h"

#import "AMPGCDExtensions.h"

#import "UINib+AMPExtensions.h"

static const NSUInteger AMPAutoresizingAll = UIViewAutoresizingFlexibleLeftMargin
                                                | UIViewAutoresizingFlexibleWidth
                                                | UIViewAutoresizingFlexibleRightMargin
                                                | UIViewAutoresizingFlexibleTopMargin
                                                | UIViewAutoresizingFlexibleHeight
                                                | UIViewAutoresizingFlexibleBottomMargin;

static const NSTimeInterval AMPLoadingViewPresentationDuration = 0.3;

static const CGFloat    AMPLoadingViewPresentedAlpha = 0.75;
static const CGFloat    AMPLoadingViewDismissedAlpha = 0;

@interface AMPLoadingView ()

- (CGFloat)alphaForState:(AMPLoadingViewState)state;

- (void)baseInit;
- (void)prepareIndicator;

@end

@implementation AMPLoadingView

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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
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

#pragma mark -
#pragma mark Public Methods

- (void)setState:(AMPLoadingViewState)state {
    [self setState:state animated:YES];
}

- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated {
    [self setState:state animated:animated completionHandler:nil];
}

- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated completionHandler:(void (^)(void))handler {
    UIActivityIndicatorView *indicator = self.indicator;

    if (AMPLoadingViewDidPresent == state) {
        [indicator startAnimating];
    }
    
    [UIView animateWithDuration:animated ? AMPLoadingViewPresentationDuration : 0
                     animations:^{
                         self.alpha = [self alphaForState:state];
                     } completion:^(BOOL finished) {
                         _state = state;
                         if (handler) {
                             handler();
                         }
                         
                         if (AMPLoadingViewDidDismiss == state) {
                             [indicator stopAnimating];
                         }
                     }];
}

#pragma mark -
#pragma mark Private Methods

- (CGFloat)alphaForState:(AMPLoadingViewState)state {
    switch (state) {
        case AMPLoadingViewDidPresent:
            return AMPLoadingViewPresentedAlpha;
            
        default:
            return AMPLoadingViewDismissedAlpha;
    }
}

- (void)baseInit {
    self.alpha = 0;
    self.backgroundColor = [UIColor blackColor];
    self.autoresizingMask = AMPAutoresizingAll;
    
    [self prepareIndicator];
}

- (void)prepareIndicator {
    UIActivityIndicatorView *indicator = self.indicator;
    if (indicator) {
        return;
    }
    
    indicator = [UIActivityIndicatorView new];
    CGRect bounds = self.bounds;
    CGRect indicatorFrame = indicator.frame;
    indicatorFrame.origin = CGPointMake(CGRectGetMidX(bounds) - CGRectGetWidth(indicatorFrame),
                                         CGRectGetMidY(bounds) - CGRectGetHeight(indicatorFrame));
    
    indicator.frame = indicatorFrame;
    indicator.autoresizingMask = AMPAutoresizingAll;
    
    self.indicator = indicator;
}

@end

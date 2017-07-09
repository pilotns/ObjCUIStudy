//
//  AMPLoadingView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMPLoadingViewState) {
    AMPLoadingViewHidden,
    AMPLoadingViewVisible
};

@interface AMPLoadingView : UIView
@property (nonatomic, assign)   AMPLoadingViewState  state;

@property (nonatomic, strong)   IBOutlet    UIActivityIndicatorView *indicator;

+ (instancetype)loadingViewInView:(UIView *)view;

- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated;
- (void)setState:(AMPLoadingViewState)state animated:(BOOL)animated completionHandler:(void (^)(void))handler;

@end

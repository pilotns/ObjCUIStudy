//
//  AMPView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 27.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPLoadingView;

@interface AMPView : UIView
@property (nonatomic, strong)   IBOutlet    AMPLoadingView  *loadingView;

- (void)setLoadingViewVisible;
- (void)setLoadingViewVisibleAnimated:(BOOL)animated;
- (void)setLoadingViewVisibleAnimated:(BOOL)animated completionHandler:(void (^)(void))handler;

- (void)setLoadingViewHidden;
- (void)setLoadingViewHiddenAnimated:(BOOL)animated;
- (void)setLoadingViewHiddenAnimated:(BOOL)animated completionHandler:(void (^)(void))handler;

// this method is intended for subclassing, do not call it directly
- (AMPLoadingView *)customLoadingView;

@end

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

@property (nonatomic, assign, getter=isLoadingViewVisible)  BOOL    loadingViewVisible;

- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated;
- (void)setLoadingViewVisible:(BOOL)yesOrNo animated:(BOOL)animated completionHandler:(void (^)(void))handler;

// this method is intended for subclassing, do not call it directly
- (AMPLoadingView *)defaultLoadingView;

@end

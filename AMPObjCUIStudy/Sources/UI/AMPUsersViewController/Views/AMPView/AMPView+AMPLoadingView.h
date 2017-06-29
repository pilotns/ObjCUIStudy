//
//  AMPView+AMPLoadingView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 29.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPView.h"

@interface AMPView (AMPLoadingView)
@property (nonatomic, readonly, getter=isLoadingViewPresented) BOOL loadingViewPresented;

- (void)presentLoadingViewAnimated:(BOOL)animated;
- (void)presentLoadingViewAnimated:(BOOL)animated completionHandler:(void (^)(void))handler;

- (void)dismissLoadingViewAnimated:(BOOL)animated;
- (void)dismissLoadingViewAnimated:(BOOL)animated completionHandler:(void (^)(void))handler;

@end

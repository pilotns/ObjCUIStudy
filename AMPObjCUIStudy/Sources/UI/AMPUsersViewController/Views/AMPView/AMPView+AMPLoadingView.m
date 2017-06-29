//
//  AMPView+AMPLoadingView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 29.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPView+AMPLoadingView.h"

#import "AMPLoadingView.h"
#import "AMPMarcos.h"

@implementation AMPView (AMPLoadingView)

@dynamic loadingViewPresented;

#pragma mark -
#pragma mark Accessors

- (BOOL)isLoadingViewPresented {
    return AMPLoadingViewDidPresent == self.loadingView.state;
}

#pragma mark -
#pragma mark Public Methods

- (void)presentLoadingViewAnimated:(BOOL)animated {
    [self presentLoadingViewAnimated:animated completionHandler:nil];
}

- (void)presentLoadingViewAnimated:(BOOL)animated completionHandler:(void (^)(void))handler {
    [self.loadingView setState:AMPLoadingViewDidPresent animated:animated completionHandler:handler];
}

- (void)dismissLoadingViewAnimated:(BOOL)animated {
    [self dismissLoadingViewAnimated:animated completionHandler:nil];
}

- (void)dismissLoadingViewAnimated:(BOOL)animated completionHandler:(void (^)(void))handler {
    [self.loadingView setState:AMPLoadingViewDidDismiss animated:animated completionHandler:handler];
}

@end

//
//  AMPViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPViewController.h"

#import "AMPSquareView.h"

@interface AMPViewController ()
@property (nonatomic, readonly)   AMPSquareView *squareView;

@end

@implementation AMPViewController

@dynamic squareView;

#pragma mark -
#pragma mark Accessors

- (AMPSquareView *)squareView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[AMPSquareView class]]) {
        return (AMPSquareView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onAuto:(UIButton *)sender {
    [self.squareView performRepeatedAnimations];
}

- (IBAction)onRandom:(UIButton *)sender {
    [self.squareView moveToRandomPosition];
}

@end

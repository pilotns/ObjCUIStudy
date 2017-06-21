//
//  AMPLoadingView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 21.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPLoadingView : UIView
@property (nonatomic, weak)     UIView      *view;

@property (nonatomic, strong)   IBOutlet    UIActivityIndicatorView *indicator;

+ (instancetype)loadingViewWithView:(UIView *)view;

- (instancetype)initWithView:(UIView *)view;

- (void)present;
- (void)dismiss;

@end

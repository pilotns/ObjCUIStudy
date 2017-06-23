//
//  AMPImageView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPImageModel;

@interface AMPImageView : UIView
@property (nonatomic, readonly) UIImageView     *contentImageView;
@property (nonatomic, strong)   AMPImageModel   *imageModel;

@end

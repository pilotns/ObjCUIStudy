//
//  AMPSquareView.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMPSquarePosition) {
    AMPSquarePositionTopLeft,
    AMPSquarePositionTopRight,
    AMPSquarePositionBottomRight,
    AMPSquarePositionBottomLeft
};

@interface AMPSquareView : UIView
@property (nonatomic, strong)   IBOutlet    UIView  *square;
@property (nonatomic, assign)   AMPSquarePosition   squarePosition;

- (void)setSquarePosition:(AMPSquarePosition)position;
- (void)setSquarePosition:(AMPSquarePosition)position animated:(BOOL)animated;
- (void)setSquarePosition:(AMPSquarePosition)position
                 animated:(BOOL)animated
        completionHanfler:(void (^)(void))handler;

- (void)randomSquarePosition;
- (void)performRepeatedAnimations;

@end

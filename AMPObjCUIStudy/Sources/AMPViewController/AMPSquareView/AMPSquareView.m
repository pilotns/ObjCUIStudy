//
//  AMPSquareView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPSquareView.h"

#import "AMPMarcos.h"

static const NSTimeInterval AMPDefaultAnimationDuration = 0.5;
static const NSTimeInterval AMPDefaultAnimationDelay    = 0;

@interface AMPSquareView ()
@property (nonatomic, assign, getter=isAllowAnimations) BOOL    allowAnimations;

- (CGPoint)squareOriginWithPosition:(AMPSquarePosition)squarePosition;
- (CGRect)squareFrameWithPosition:(AMPSquarePosition)squarePosition;

- (AMPSquarePosition)nextPosition;
- (void)cyclicallyChangePosition;

@end

@implementation AMPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setAllowAnimations:(BOOL)allowAnimations {
    if (_allowAnimations != allowAnimations) {
        _allowAnimations = allowAnimations;
        
        if (_allowAnimations) {
            [self cyclicallyChangePosition];
        }
    }
}

- (void)setSquarePosition:(AMPSquarePosition)position {
    [self setSquarePosition:position animated:NO];
}

- (void)setSquarePosition:(AMPSquarePosition)position animated:(BOOL)animated {
    [self setSquarePosition:position animated:animated completionHanfler:nil];
}

- (void)setSquarePosition:(AMPSquarePosition)position
                 animated:(BOOL)animated
        completionHanfler:(void (^)(void))handler
{
    if (!self.isAllowAnimations) {
        return;
    }
    
    [UIView animateWithDuration:AMPDefaultAnimationDuration
                          delay:AMPDefaultAnimationDelay
                        options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.square.frame = [self squareFrameWithPosition:position];
                     }
                     completion:^(BOOL finished) {
                         _squarePosition = position;
                         
                         if (handler) {
                             handler();
                         }
                     }];
}

#pragma mark -
#pragma mark - Public Methods

- (void)randomSquarePosition {
    AMPSquarePosition randomPosition = arc4random_uniform(AMPSquarePositionBottomLeft + 1);
    
    [self setSquarePosition:randomPosition animated:YES];
}

- (void)performRepeatedAnimations {
    self.allowAnimations = !self.allowAnimations;
}

#pragma mark -
#pragma mark Private Methods

- (CGPoint)squareOriginWithPosition:(AMPSquarePosition)position {
    CGRect squareViewFrame = self.bounds;
    CGRect squareFrame = self.square.frame;
    switch (position) {
        case AMPSquarePositionTopLeft:
            return CGPointZero;
            
        case AMPSquarePositionTopRight:
            return CGPointMake(CGRectGetMaxX(squareViewFrame) - CGRectGetWidth(squareFrame),
                               CGRectGetMinY(squareViewFrame));
            
        case AMPSquarePositionBottomRight:
            return CGPointMake(CGRectGetMaxX(squareViewFrame) - CGRectGetWidth(squareFrame),
                               CGRectGetMaxY(squareViewFrame) - CGRectGetHeight(squareFrame));
            
        case AMPSquarePositionBottomLeft:
            return CGPointMake(CGRectGetMinX(squareViewFrame),
                               CGRectGetMaxY(squareViewFrame) - CGRectGetHeight(squareFrame));
            
        default:
            return CGPointZero;
    }
}

- (CGRect)squareFrameWithPosition:(AMPSquarePosition)position {
    CGRect squareFrame = self.square.frame;
    squareFrame.origin = [self squareOriginWithPosition:position];
    
    return squareFrame;
}

- (void)cyclicallyChangePosition {
    AMPWeakify(self);
    [self setSquarePosition:[self nextPosition] animated:YES completionHanfler:^{
        AMPStrongify(self);
        [self cyclicallyChangePosition];
    }];
}

- (AMPSquarePosition)nextPosition {
    AMPSquarePosition currentPosition = self.squarePosition;
    
    return ++currentPosition % (AMPSquarePositionBottomLeft + 1);
}

@end

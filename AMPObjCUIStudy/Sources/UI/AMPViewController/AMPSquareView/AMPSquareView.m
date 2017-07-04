//
//  AMPSquareView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPSquareView.h"

#import "AMPRandom.h"
#import "AMPMacro.h"

static const NSUInteger     AMPSquarePositionCount      = AMPSquarePositionBottomLeft + 1;
static const NSTimeInterval AMPDefaultAnimationDuration = 0.5;
static const NSTimeInterval AMPDefaultAnimationDelay    = 0;

@interface AMPSquareView ()
@property (nonatomic, assign, getter=isStarted)    BOOL    started;

@property (nonatomic, assign, getter=isAllowBeginChangePosition)    BOOL    allowBeginChangePosition;

- (CGPoint)squareOriginWithPosition:(AMPSquarePosition)position;
- (CGRect)squareFrameWithPosition:(AMPSquarePosition)position;

- (AMPSquarePosition)nextPosition;
- (AMPSquarePosition)randomPosition;

- (void)cyclicallyChangePosition;

- (BOOL)shouldChangePosition;

@end

@implementation AMPSquareView

#pragma mark -
#pragma mark Accessors

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
    [UIView animateWithDuration:animated ? AMPDefaultAnimationDuration : 0
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

- (void)moveToRandomPosition {
     [self setSquarePosition:[self randomPosition] animated:YES];
}

- (void)performRepeatedAnimations {
    self.allowBeginChangePosition = !self.isAllowBeginChangePosition;
    
    [self cyclicallyChangePosition];
}

#pragma mark -
#pragma mark Private Methods

- (CGPoint)squareOriginWithPosition:(AMPSquarePosition)position {
    CGRect squareViewFrame = self.bounds;
    CGRect squareFrame = self.square.frame;

    CGPoint point = squareViewFrame.origin;
    CGPoint bottomRightPoint = CGPointMake(CGMaxX(squareViewFrame) - CGWidth(squareFrame),
                                           CGMaxY(squareViewFrame) - CGHeight(squareFrame));
    
    switch (position) {
        case AMPSquarePositionTopRight:
            point.x = bottomRightPoint.x;
            break;
            
        case AMPSquarePositionBottomRight:
            point = bottomRightPoint;
            break;
            
        case AMPSquarePositionBottomLeft:
            point.y = bottomRightPoint.y;
            
        default:
            break;
    }
    
    return point;
}

- (CGRect)squareFrameWithPosition:(AMPSquarePosition)position {
    CGRect squareFrame = self.square.frame;
    squareFrame.origin = [self squareOriginWithPosition:position];
    
    return squareFrame;
}

- (AMPSquarePosition)nextPosition {
    return (self.squarePosition + 1) % AMPSquarePositionCount;
}

- (AMPSquarePosition)randomPosition {
    return AMPRandomValueUntilLocation(AMPSquarePositionCount);
}

- (void)cyclicallyChangePosition {
    if ([self shouldChangePosition]) {
        AMPWeakify(self);
        self.started = YES;
        [self setSquarePosition:[self nextPosition] animated:YES completionHanfler:^{
            AMPStrongifyAndReturnIfNil(self);
            self.started = NO;
            [self cyclicallyChangePosition];
        }];
    }
}

- (BOOL)shouldChangePosition {
    return !self.started && self.isAllowBeginChangePosition;
}

@end

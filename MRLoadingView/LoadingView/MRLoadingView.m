//
//  MARefreshControl.m
//  MAMovesAnimationView
//
//  Created by Sheldon on 14-5-23.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "MRLoadingView.h"

@implementation MRLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.15 green:0.7 blue:0.92 alpha:1].CGColor;
    _progressLayer.lineWidth = 4;
    _progressLayer.frame = self.bounds;
    [self.layer addSublayer:_progressLayer];
}

- (void)startLoading
{
    [self clockwiseAnimation];
}

- (void)endLoading
{
    [_progressLayer removeAllAnimations];
    _progressLayer.path = nil;
}

#pragma mark - Animation Delegate -

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"id"] isEqualToString:@"anticlockwiseKey"]) {
        if (flag) {
            _progressLayer.path = nil;
            self.transform = CGAffineTransformRotate(self.transform, - M_PI * 0.8);
            [self performSelector:@selector(clockwiseAnimation) withObject:self afterDelay:0.2];
        }
    } else {
        if (flag) {
            [UIView animateWithDuration:0.6 animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI * 0.8);
            } completion:^(BOOL finished) {
                if (finished) {
                    [self anticlockwiseAnimation];
                }
            }];
        }
    }
}

#pragma mark - Private Methods -

- (void)clockwiseAnimation
{
    UIBezierPath * clockwisePath = [UIBezierPath bezierPath];
    CGRect rect = self.bounds;
     [clockwisePath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:CGRectGetHeight(self.bounds) / 2 startAngle:- 0.5 * M_PI endAngle:0.7 * M_PI clockwise:YES];
    
    _progressLayer.path = clockwisePath.CGPath;
    
    CABasicAnimation *clockwiseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [clockwiseAnimation setValue:@"clockwiseKey" forKey:@"id"];
    clockwiseAnimation.duration = 1;
    clockwiseAnimation.delegate = self;
    clockwiseAnimation.fromValue = @0;
    clockwiseAnimation.toValue = @1;
    clockwiseAnimation.removedOnCompletion = YES;
    clockwiseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_progressLayer addAnimation:clockwiseAnimation forKey:@"clockwiseKey"];
}

- (void)anticlockwiseAnimation
{
    CABasicAnimation *anticlockwiseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    [anticlockwiseAnimation setValue:@"anticlockwiseKey" forKey:@"id"];
    anticlockwiseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anticlockwiseAnimation.delegate = self;
    anticlockwiseAnimation.duration = 1;
    anticlockwiseAnimation.fromValue = @0;
    anticlockwiseAnimation.toValue = @1;
    anticlockwiseAnimation.removedOnCompletion = YES;
    [_progressLayer addAnimation:anticlockwiseAnimation forKey:@"anticlockwiseKey"];
}

@end

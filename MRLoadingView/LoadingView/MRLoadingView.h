//
//  MARefreshControl.h
//  MAMovesAnimationView
//
//  Created by Sheldon on 14-5-23.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRLoadingView : UIView
{
    CAShapeLayer *_progressLayer;
}

- (void)startLoading;
- (void)endLoading;

@end

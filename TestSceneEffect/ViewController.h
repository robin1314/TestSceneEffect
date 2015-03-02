//
//  ViewController.h
//  TestSceneEffect
//
//  Created by robin on 15/2/26.
//  Copyright (c) 2015年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "testConstant.h"

#import "AVBasicRouteAnimate.h"

#define AD_Z_DISTANCE 1000.0f

@interface ViewController : UIViewController
{
    CALayer *homeLayer;
    
}

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end


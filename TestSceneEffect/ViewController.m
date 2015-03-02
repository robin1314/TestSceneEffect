//
//  ViewController.m
//  TestSceneEffect
//
//  Created by robin on 15/2/26.
//  Copyright (c) 2015年 robin. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    homeLayer = [CALayer layer];
    
    homeLayer.frame = CGRectMake(0, 30, self.view.frame.size.width, 180);
    
    [self.view.layer addSublayer: homeLayer];
    
    float zDistance = AD_Z_DISTANCE;
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -zDistance;
    homeLayer.sublayerTransform = sublayerTransform;
}

-(void)colorClop
{
    CGFloat duration = 2.0;
    
    CGFloat beginTime = 0;
    
    CALayer *currentLayer = [CALayer layer];
    
    currentLayer.frame = homeLayer.bounds;
    
    currentLayer.contents = (id)[UIImage imageNamed:@"camra.jpg"].CGImage;
    
    [homeLayer addSublayer: currentLayer];
    
    CAShapeLayer  *maskLayer = [CAShapeLayer layer];
    
    //maskLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CGFloat arcSidelength = currentLayer.frame.size.width*2;
    
    // arcSidelength = 100;
    
    maskLayer.frame = CGRectMake(0, 0, arcSidelength, arcSidelength);
    
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    
    UIBezierPath *arcPath = [UIBezierPath bezierPath];
    // Set the starting point of the shape.
    [arcPath moveToPoint:CGPointMake(0, 0)];
    // Draw the lines
    [arcPath addLineToPoint:CGPointMake(arcSidelength ,0)];
    [arcPath addLineToPoint:CGPointMake(arcSidelength, arcSidelength)];
    [arcPath addLineToPoint:CGPointMake(0,0)];
    [arcPath closePath];
    
    maskLayer.path = arcPath.CGPath;
    
    maskLayer.position = CGPointMake(currentLayer.frame.size.width, 0);
    
    CGPoint arcToCenter = CGPointMake(0, currentLayer.frame.size.height);
    
    CABasicAnimation *moveMaskAni = [AVBasicRouteAnimate moveXYCenterTo:duration-0.2 withBeginTime:beginTime toValue: arcToCenter];
    
    // maske effect
    CAGradientLayer  *maskEffectLayer = [CAGradientLayer layer];
    
    CGFloat colorSidelength = currentLayer.frame.size.width*1.6;
    
    maskEffectLayer.frame =CGRectMake(0, 0,colorSidelength,  currentLayer.frame.size.height*1.7);
    
    // 设置颜色
    maskEffectLayer.colors = @[(id)[[UIColor brownColor] colorWithAlphaComponent:0.4].CGColor,
                               (id)UIColorFromRGB(0xb31921).CGColor,
                               (id)UIColorFromRGB(0xb31921).CGColor,
                               (id)UIColorFromRGB(0xd67a51).CGColor,
                               (id)UIColorFromRGB(0xd67a51).CGColor,
                               (id)UIColorFromRGB(0x664e66).CGColor,
                               (id)UIColorFromRGB(0x664e66).CGColor,
                               ];
    
    maskEffectLayer.locations = @[[NSNumber numberWithFloat:0.30f],
                                  [NSNumber numberWithFloat:0.31f],
                                  
                                  [NSNumber numberWithFloat:0.54f],
                                  [NSNumber numberWithFloat:0.55f],
                                  
                                  [NSNumber numberWithFloat:0.85f],
                                  [NSNumber numberWithFloat:0.86f],
                                  
                                  ];
    
    maskEffectLayer.anchorPoint = CGPointMake(0.5, 1.0);
    
    CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);  // Rotate 45.z
    
    maskEffectLayer.transform = rotate1;
    
    maskEffectLayer.position = CGPointMake(currentLayer.frame.size.width, 0);
    
    CGPoint nextPosition = CGPointMake(-(maskEffectLayer.frame.size.height/2), currentLayer.frame.size.height+30);
    
    CABasicAnimation *moveAni = [AVBasicRouteAnimate moveXYCenterTo:duration withBeginTime:beginTime toValue: nextPosition];
    
    //  dispatch_async_main_after(kCATransactionBTime(beginTime), ^{
    [currentLayer.superlayer addSublayer: nextLayer];
    
    [maskLayer addAnimation: moveMaskAni forKey:@"moveAni"];
    
    //[currentLayer.superlayer addSublayer: maskLayer];
    [nextLayer setMask:maskLayer];
    
    [maskEffectLayer addAnimation: moveAni forKey:@"moveAni"];
    [currentLayer.superlayer addSublayer: maskEffectLayer];
}

-(void) shapeArcSlide
{
    CALayer *currentLayer = [CALayer layer];
    
    currentLayer.frame = homeLayer.bounds;
    
    currentLayer.contents = (id)[UIImage imageNamed:@"camra.jpg"].CGImage;
    
    [homeLayer addSublayer: currentLayer];
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    
    // Set the starting point of the shape.
    [startPath moveToPoint:CGPointMake(0, 0)];
    
    // Draw the lines
    [startPath addLineToPoint:CGPointMake(currentLayer.bounds.size.width/2 ,0)];
    [startPath addLineToPoint:CGPointMake(currentLayer.bounds.size.width/2, currentLayer.bounds.size.height/2)];
    [startPath addLineToPoint:CGPointMake(0,0)];
    
    [startPath closePath];
    
    CAShapeLayer *geometryLayer = [CAShapeLayer layer];
    
    geometryLayer.frame = currentLayer.bounds;
    
    geometryLayer.backgroundColor = [UIColor clearColor].CGColor;
    geometryLayer.path = startPath.CGPath;
    
    geometryLayer.fillColor = [UIColor whiteColor].CGColor;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
    
    geometryLayer.affineTransform = transform;
    
    // [currentLayer addSublayer: geometryLayer];
    
    //[currentLayer setMask: geometryLayer];
    
    // maske effect
    CAGradientLayer  *maskEffectLayer = [CAGradientLayer layer];
    
    CGFloat colorSidelength = currentLayer.frame.size.width*1.5;
    
    maskEffectLayer.frame =CGRectMake(0, 0,colorSidelength,  currentLayer.frame.size.height*1.7);
    
    // 设置颜色
    maskEffectLayer.colors = @[(id)[[UIColor brownColor] colorWithAlphaComponent:0.3].CGColor,
                               (id)UIColorFromRGB(0xb31921).CGColor,
                               (id)UIColorFromRGB(0xb31921).CGColor,
                               (id)UIColorFromRGB(0xd67a51).CGColor,
                               (id)UIColorFromRGB(0xd67a51).CGColor,
                               (id)UIColorFromRGB(0x664e66).CGColor,
                               (id)UIColorFromRGB(0x664e66).CGColor,
                               ];
    
    maskEffectLayer.locations = @[[NSNumber numberWithFloat:0.30f],
                                  [NSNumber numberWithFloat:0.31f],
                                  
                                  [NSNumber numberWithFloat:0.54f],
                                  [NSNumber numberWithFloat:0.55f],
                                  
                                  [NSNumber numberWithFloat:0.85f],
                                  [NSNumber numberWithFloat:0.86f],
                                  
                                  ];
    
    // maskEffectLayer.anchorPoint = CGPointMake(0.5, 1.0);
    
    CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);  // Rotate 45.z
    
    maskEffectLayer.transform = rotate1;
    
    maskEffectLayer.position = CGPointMake(100, 200);
    
    //    maskEffectLayer.startPoint = CGPointMake(0.5, 0.5);
    //
    //    maskEffectLayer.endPoint = CGPointMake(0.5, 1.0);
    
    [homeLayer addSublayer: maskEffectLayer];
    
    CGPoint nextPosition = CGPointMake(-currentLayer.position.x, currentLayer.position.y+currentLayer.frame.size.height);
    
    
    
    //test
    CAShapeLayer  *maskLayer = [CAShapeLayer layer];
    
    maskLayer.backgroundColor = [UIColor redColor].CGColor;
    
    maskLayer.frame = currentLayer.bounds;
    
    // maskLayer.position = CGPointMake(100, 50);
    
    maskLayer.anchorPoint = CGPointMake(0, 0.5);
    
    // [homeLayer addSublayer: maskLayer];
    
}

@end

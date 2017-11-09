//
//  YouKuPlayButton.m
//  YJPlayButton
//
//  Created by 包宇津 on 2017/11/9.
//  Copyright © 2017年 baoyujin. All rights reserved.
//

#import "YouKuPlayButton.h"

static CGFloat animationDuration = 0.35f;
#define BlueColor [UIColor colorWithRed:62/255.0 green:157/255.0 blue:254/255.0 alpha:1]
#define LightBlueColor [UIColor colorWithRed:87/255.0 green:185/255.0 blue:253/255.0 alpha:1]
#define RedColor [UIColor colorWithRed:288/255.0 green:35/255.0 blue:6/255.0 alpha:0.8]

@interface YouKuPlayButton(){
    CAShapeLayer *_leftLineLayer;
    CAShapeLayer *_leftCircle;
    CAShapeLayer *_rightLineLayer;
    CAShapeLayer *_rightCircle;
    CALayer *_triangelContainer;
    BOOL _isAnimating;
}
@end

@implementation YouKuPlayButton

- (instancetype)initWithFrame:(CGRect)frame state:(YouKuPlayButtonState)state {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        if (state == YouKuPlayButtonStatePlay) {
            self.buttonState = state;
        }
    }
    return self;
}

#pragma mark -setupUI
- (void)setupUI {
    [self addLeftCircle];
    [self addRightCircle];
    [self addLeftLineLayer];
    [self addRightLineLayer];
    [self addCenterTriangleLayer];
}

#pragma mark --setter
- (void)setButtonState:(YouKuPlayButtonState)buttonState {
    if (_isAnimating) {
        return;
    }
    _buttonState = buttonState;
    _isAnimating = true;
    if (buttonState == YouKuPlayButtonStatePlay){
        [self showPlayAnimation];
    }else if (buttonState == YouKuPlayButtonStatePause) {
        [self showPauseAnimation];
    }
    //更新动画执行状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimating = false;
    });
}
#pragma mark --Layer
/**
 添加左侧竖线层
 */
- (void)addLeftLineLayer {
    CGFloat a = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2 * a, 0.9 * a)];
    [path addLineToPoint:CGPointMake(0.2 * a, 0.1 * a)];
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = BlueColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_leftLineLayer];
}

- (CGFloat)lineWidth {
    return self.layer.bounds.size.width * 0.18;
}

/**
 添加左侧圆弧
*/
- (void)addLeftCircle {
    CGFloat a = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2 * a, 0.9 * a)];
    CGFloat startAngle = acos(4.0/5.0) + M_PI_2;
    CGFloat endAngle = startAngle - M_PI;
    [path addArcWithCenter:CGPointMake(0.5 * a, 0.5 * a) radius:0.5 * a startAngle:startAngle endAngle:endAngle clockwise:false];
    _leftCircle = [CAShapeLayer layer];
    _leftCircle.path = path.CGPath;
    _leftCircle.fillColor = [UIColor clearColor].CGColor;
    _leftCircle.strokeColor = LightBlueColor.CGColor;
    _leftCircle.lineWidth = [self lineWidth];
    _leftCircle.lineCap = kCALineCapRound;
    _leftCircle.lineJoin = kCALineJoinRound;
    _leftCircle.strokeEnd = 0;
    [self.layer addSublayer:_leftCircle];
}

/**
 添加右侧竖线
 */
- (void)addRightLineLayer {
    CGFloat a = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8 * a, 0.1 * a)];
    [path addLineToPoint:CGPointMake(0.8 * a, 0.9 * a)];
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = BlueColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
}


/**
 添加右侧圆弧
 */
- (void)addRightCircle {
    CGFloat a = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8 * a, 0.1 * a)];
    CGFloat startAngle = -asin(4.0/5.0);
    CGFloat endAngle = startAngle - M_PI;
    [path addArcWithCenter:CGPointMake(0.5 * a, 0.5 * a) radius:0.5 * a startAngle:startAngle endAngle:endAngle clockwise:false];
    _rightCircle = [CAShapeLayer layer];
    _rightCircle.path = path.CGPath;
    _rightCircle.fillColor = [UIColor clearColor].CGColor;
    _rightCircle.strokeColor = LightBlueColor.CGColor;
    _rightCircle.lineWidth = [self lineWidth];
    _rightCircle.lineCap = kCALineCapRound;
    _rightCircle.lineJoin = kCALineJoinRound;
    _rightCircle.strokeEnd = 0;
    [self.layer addSublayer:_rightCircle];
}

/**
 添加三角
 */
- (void)addCenterTriangleLayer {
    CGFloat a = self.layer.bounds.size.width;
    _triangelContainer = [CALayer layer];
    _triangelContainer.bounds = CGRectMake(0, 0, 0.4 * a, 0.35 * a);
    _triangelContainer.position = CGPointMake(0.5 * a, 0.55 * a);
    _triangelContainer.opacity = 0;
    [self.layer addSublayer:_triangelContainer];
    CGFloat bWidth = _triangelContainer.bounds.size.width;
    CGFloat cHeight = _triangelContainer.bounds.size.height;
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(bWidth/2, cHeight)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(bWidth, 0)];
    [path2 addLineToPoint:CGPointMake(bWidth/2, cHeight)];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.fillColor = [UIColor clearColor].CGColor;
    layer1.strokeColor = RedColor.CGColor;
    layer1.lineWidth = [self lineWidth];
    layer1.lineCap = kCALineCapRound;
    layer1.lineJoin = kCALineJoinRound;
    layer1.strokeEnd = 1;
    [_triangelContainer addSublayer:layer1];
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path2.CGPath;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = RedColor.CGColor;
    layer2.lineWidth = [self lineWidth];
    layer2.lineCap = kCALineCapRound;
    layer2.lineJoin = kCALineJoinRound;
    layer2.strokeEnd = 1;
    [_triangelContainer addSublayer:layer2];
}

#pragma mark --Animation
#pragma mark -
#pragma mark 动画方法
/**
 strokeEnd 动画
 */
- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue onLayer:(CALayer *)layer name:(NSString *)animationName duration:(CGFloat)duration delegate:(id)delegate {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(fromValue);
    strokeEndAnimation.toValue = @(toValue);
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [strokeEndAnimation setValue:animationName forKey:@"animationName"];
    strokeEndAnimation.delegate = delegate;
    [layer addAnimation:strokeEndAnimation forKey:nil];
    return strokeEndAnimation;
}

/**
 执行旋转动画
 */
- (void)actionRotateAnimationClockwise:(BOOL)clockwise {
    CGFloat startAngle = 0.0;
    CGFloat endAngle = -M_PI_2;
    CGFloat duration = 0.75 * animationDuration;
    //顺时针
    if (clockwise) {
        startAngle = -M_PI_2;
        endAngle = 0.0;
        duration = animationDuration;
    }
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.duration = duration;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:startAngle];
    rotateAnimation.toValue = [NSNumber numberWithFloat:endAngle];
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    [rotateAnimation setValue:@"rotateAnimation" forKey:@"animationName"];
    [self.layer addAnimation:rotateAnimation forKey:nil];
}

/**
 三角图形的 透明度
 */
- (void)actionTriangleAlphaAnimationFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration {
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.duration = duration;
    alphaAnimation.fromValue = @(from);
    alphaAnimation.toValue = @(to);
    alphaAnimation.fillMode = kCAFillModeForwards;
    alphaAnimation.removedOnCompletion = NO;
    [alphaAnimation setValue:@"alphaAnimation" forKey:@"animationName"];
    [_triangelContainer addAnimation:alphaAnimation forKey:nil];
}

/**
 暂停 -> 播放
 */
- (void)showPlayAnimation {
    //收起直线，弧线出现
    [self strokeEndAnimationFrom:1 to:0 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightLineLayer name:nil duration:animationDuration/2 delegate:nil];
    [self strokeEndAnimationFrom:0 to:1 onLayer:_leftCircle name:nil duration:animationDuration delegate:nil];
    [self strokeEndAnimationFrom:0 to:1 onLayer:_rightCircle name:nil duration:animationDuration delegate:nil];
    //开始旋转动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, animationDuration/4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self actionRotateAnimationClockwise:false];
    });
    //三角透明度变化
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, animationDuration/2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self actionTriangleAlphaAnimationFrom:0 to:1 duration:animationDuration/2];
    });
}

/**
 播放 -> 暂停 动画
 */
- (void)showPauseAnimation {
    //收弧线
    [self strokeEndAnimationFrom:1 to:0 onLayer:_leftCircle name:nil duration:animationDuration delegate:nil];
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightCircle name:nil duration:animationDuration delegate:nil];
    [self actionTriangleAlphaAnimationFrom:1 to:0 duration:animationDuration/2];
    [self actionRotateAnimationClockwise:true];
    //收到一半 再放出直线
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, animationDuration/2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self strokeEndAnimationFrom:0 to:1 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
        [self strokeEndAnimationFrom:0 to:1 onLayer:_rightLineLayer name:nil duration:animationDuration/2 delegate:nil];
    });
}
@end

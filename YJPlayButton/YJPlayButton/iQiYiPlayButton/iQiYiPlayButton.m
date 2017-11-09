//
//  iQiYiPlayButton.m
//  YJPlayButton
//
//  Created by 包宇津 on 2017/11/9.
//  Copyright © 2017年 baoyujin. All rights reserved.
//
#import "iQiYiPlayButton.h"

//动画时长
static CGFloat animationDuration = 0.5f;
//位移动画时长
static CGFloat positionDuration = 0.3f;
//线条颜色
#define LineColor  [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
//三角动画名称
#define TriangleAnimation @"TriangleAnimation"
//右侧直线动画名称
#define RightLineAnimation @"RightLineAnimation"

@interface iQiYiPlayButton() {
    BOOL _isAnimating;
    CAShapeLayer *_leftLineLayer;
    CAShapeLayer *_rightLineLayer;
    CAShapeLayer *_triangleLayer;
    CAShapeLayer *_circleLayer;
}
@end

@implementation iQiYiPlayButton

- (instancetype)initWithFrame:(CGRect)frame state:(iQiYiPlayButtonState)state {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        if (state == iQiYiPlayButtonStaePlay) {
            self.buttonState = state;
        }
    }
    return self;
}

#pragma mark --UI
- (void)setupUI {
    [self addTriangleLayer];
    [self addLeftLineLayer];
    [self addRightLineLayer];
    [self addCircleLayer];
}

#pragma mark --Add Layer
//添加三角动画
- (void)addTriangleLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2 * a, 0.2 * a)];
    [path addLineToPoint:CGPointMake(0.2 * a, 0)];
    [path addLineToPoint:CGPointMake(a,0.5 * a)];
    [path addLineToPoint:CGPointMake(0.2 * a, a)];
    [path addLineToPoint:CGPointMake(0.2 * a, 0.2 * a)];
    
    _triangleLayer = [CAShapeLayer layer];
    _triangleLayer.path = path.CGPath;
    _triangleLayer.fillColor = [UIColor clearColor].CGColor;
    _triangleLayer.strokeColor = LineColor.CGColor;
    _triangleLayer.lineWidth = [self lineWidth];
    _triangleLayer.lineCap = kCALineCapRound;
    _triangleLayer.lineJoin = kCALineJoinRound;
    _triangleLayer.strokeEnd = 0;
    [self.layer addSublayer:_triangleLayer];
}
- (CGFloat)lineWidth {
    return self.bounds.size.width * 0.2;
}

//左侧竖线
- (void)addLeftLineLayer {
    CGFloat a = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.2 * a, 0)];
    [path addLineToPoint:CGPointMake(0.2 * a, a)];
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = LineColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_leftLineLayer];
}

//右侧竖线
- (void)addRightLineLayer {
    CGFloat a = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8 * a, a)];
    [path addLineToPoint:CGPointMake(0.8 * a, 0)];
    
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = LineColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
}

//弧线
- (void)addCircleLayer {
    CGFloat a = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.8 * a, 0.8 * a)];
    [path addArcWithCenter:CGPointMake(0.5 * a, 0.8 * a) radius:0.3 * a startAngle:0 endAngle:M_PI clockwise:true];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = LineColor.CGColor;
    _circleLayer.lineWidth = [self lineWidth];
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineJoin = kCALineJoinRound;
    _circleLayer.strokeEnd = 0;
    [self.layer addSublayer:_circleLayer];
}

#pragma mark --Animation


/**
 暂停 -> 播放
 */
- (void)actionPositiveAnimation {
    //开始三角动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_triangleLayer name:TriangleAnimation duration:animationDuration delegate:self];
    //右侧线条动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightLineLayer name:RightLineAnimation duration:animationDuration/4 delegate:self];
     //弧线
    [self strokeEndAnimationFrom:0 to:1 onLayer:_circleLayer name:nil duration:animationDuration/4 delegate:nil];
    //逆向画弧线
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * 0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationFrom:0 to:1];
    });
    //左侧线条动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self strokeEndAnimationFrom:1 to:0 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
    });
}


/**
 播放 -> 暂停
 */
- (void)actionInverseAnimation {
    //三角动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:_triangleLayer name:TriangleAnimation duration:animationDuration delegate:self];
    //左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
    //画弧
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationFrom:1 to:0];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * 0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //右侧竖线
        [self strokeEndAnimationFrom:0 to:1 onLayer:_rightLineLayer name:RightLineAnimation duration:animationDuration/4 delegate:self];
        //圆弧动画
        [self strokeEndAnimationFrom:1 to:0 onLayer:_circleLayer name:nil duration:animationDuration/4 delegate:nil];
    });
}
/**
 通用执行strokeEnd动画
 */
- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue onLayer:(CALayer *)layer name:(NSString*)animationName duration:(CGFloat)duration delegate:(id)delegate {
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
 画弧改变起始位置动画
 */
- (void)circleStartAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue {
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    circleAnimation.duration = animationDuration/4;
    circleAnimation.fromValue = @(fromValue);
    circleAnimation.toValue = @(toValue);
    circleAnimation.fillMode = kCAFillModeForwards;
    circleAnimation.removedOnCompletion = NO;
    [_circleLayer addAnimation:circleAnimation forKey:nil];
}
- (CABasicAnimation *)pathAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    return pathAnimation;
}
#pragma mark --竖线动画

/**
 暂停 -> 播放
 */
- (void)linePositiveAnimation {
    CGFloat a = self.bounds.size.width;
    //左侧缩放动画
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(0.2 * a, 0.4 * a)];
    [leftPath1 addLineToPoint:CGPointMake(0.2 * a, a)];
    _leftLineLayer.path = leftPath1.CGPath;
    [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration / 2] forKey:nil];
    
    //右侧竖线缩放动画
    UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
    [rightPath2 moveToPoint:CGPointMake(0.8 * a, 0.8 * a)];
    [rightPath2 addLineToPoint:CGPointMake(0.8 *a, -0.2 * a)];
    _rightLineLayer.path = rightPath2.CGPath;
    [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //左侧竖线位移动画
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(0.2 * a, 0.2 * a)];
        [leftPath2 addLineToPoint:CGPointMake(0.2 * a, 0.8 * a)];
        _leftLineLayer.path = leftPath2.CGPath;
        [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
        
        //右侧竖线位移动画
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(0.8 * a, 0.8 * a)];
        [rightPath2 addLineToPoint:CGPointMake(0.8 * a, 0.2 * a)];
        _rightLineLayer.path = rightPath2.CGPath;
        [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
        
    });
}

/**
 播放 -> 暂停
 */
- (void)lineInvserseAnimation {
    //左侧位移动画
    CGFloat a = self.bounds.size.width;
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(0.2 * a, 0.4 * a)];
    [leftPath1 addLineToPoint:CGPointMake(0.2 * a, a)];
    _leftLineLayer.path = leftPath1.CGPath;
    [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    
    //右侧位移动画
    UIBezierPath *rightPath1 = [UIBezierPath bezierPath];
    [rightPath1 moveToPoint:CGPointMake(0.8 * a, 0.8 * a)];
    [rightPath1 addLineToPoint:CGPointMake(0.8 * a, -0.2 * a)];
    _rightLineLayer.path = rightPath1.CGPath;
    [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //左侧竖线动画
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(0.2 * a, 0)];
        [leftPath2 addLineToPoint:CGPointMake(0.2 * a, a)];
        _leftLineLayer.path = leftPath2.CGPath;
        [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
        
        //右侧竖线动画
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(0.8 * a, a)];
        [rightPath2 addLineToPoint:CGPointMake(0.8 * a, 0)];
        _rightLineLayer.path = rightPath2.CGPath;
        [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    });
}
#pragma mark --Setter
- (void)setButtonState:(iQiYiPlayButtonState)buttonState {
    if (_isAnimating) {
        return;
    }
    _buttonState = buttonState;
    if (buttonState == iQiYiPlayButtonStaePlay) {
        _isAnimating = true;
        //竖线正向动画
        [self linePositiveAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self actionPositiveAnimation];
        });
    }else if (buttonState == iQiYiPlayButtonStatePause) {
        _isAnimating = true;
        [self actionInverseAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self lineInvserseAnimation];
        });
    }
    //更新动画状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((positionDuration + animationDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimating = false;
    });
}
//为了避免动画结束回到原点后会有一个原点显示在屏幕上需要做一些处理，就是改变layer的lineCap属性
-(void)animationDidStart:(CAAnimation *)anim {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapRound;
    }else if (isRightLine){
        _rightLineLayer.lineCap = kCALineCapRound;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (_buttonState == iQiYiPlayButtonStaePlay && isRightLine) {
        _rightLineLayer.lineCap = kCALineCapButt;
    } else if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapButt;
    }
}
@end

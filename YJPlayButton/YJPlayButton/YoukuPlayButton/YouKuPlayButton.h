//
//  YouKuPlayButton.h
//  YJPlayButton
//
//  Created by 包宇津 on 2017/11/9.
//  Copyright © 2017年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YouKuPlayButtonState) {
    YouKuPlayButtonStatePause = 0,
    YouKuPlayButtonStatePlay
};
    

@interface YouKuPlayButton : UIButton

@property (nonatomic, assign) YouKuPlayButtonState buttonState;
- (instancetype)initWithFrame:(CGRect)frame state:(YouKuPlayButtonState)state;

@end

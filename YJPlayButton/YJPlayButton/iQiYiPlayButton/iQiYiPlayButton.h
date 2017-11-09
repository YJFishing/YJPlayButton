//
//  iQiYiPlayButton.h
//  YJPlayButton
//
//  Created by 包宇津 on 2017/11/9.
//  Copyright © 2017年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,iQiYiPlayButtonState) {
    iQiYiPlayButtonStatePause = 0,
    iQiYiPlayButtonStaePlay
};
@interface iQiYiPlayButton : UIButton

@property (nonatomic, assign) iQiYiPlayButtonState buttonState;
- (instancetype)initWithFrame:(CGRect)frame state:(iQiYiPlayButtonState)state;

@end

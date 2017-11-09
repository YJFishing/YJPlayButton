//
//  ViewController.m
//  YJPlayButton
//
//  Created by 包宇津 on 2017/11/9.
//  Copyright © 2017年 baoyujin. All rights reserved.
//

#import "ViewController.h"
#import "YouKuPlayButton.h"
#import "iQiYiPlayButton.h"

@interface ViewController (){
    YouKuPlayButton *_youkuPlayButton;
    iQiYiPlayButton *_iqiyiPlayButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _youkuPlayButton = [[YouKuPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:YouKuPlayButtonStatePlay];
    [_youkuPlayButton addTarget:self action:@selector(youkuPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    _youkuPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
    [self.view addSubview:_youkuPlayButton];
    
    _iqiyiPlayButton = [[iQiYiPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:iQiYiPlayButtonStaePlay];
    _iqiyiPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3 * 2);
    [_iqiyiPlayButton addTarget:self action:@selector(iqiyiPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_iqiyiPlayButton];
}
- (void)youkuPlayMethod {
    if (_youkuPlayButton.buttonState == YouKuPlayButtonStatePause) {
        _youkuPlayButton.buttonState = YouKuPlayButtonStatePlay;
    }else {
        _youkuPlayButton.buttonState = YouKuPlayButtonStatePause;
    }
}

- (void)iqiyiPlayMethod {
    if (_iqiyiPlayButton.buttonState == iQiYiPlayButtonStaePlay) {
        _iqiyiPlayButton.buttonState = iQiYiPlayButtonStatePause;
    }else {
        _iqiyiPlayButton.buttonState = iQiYiPlayButtonStaePlay;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

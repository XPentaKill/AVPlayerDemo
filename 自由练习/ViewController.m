//
//  ViewController.m
//  自由练习
//
//  Created by 莘英发 on 2018/4/12.
//  Copyright © 2018年 莘英发. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YFPlayView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
// 播放视频的view
@property (nonatomic, strong) YFPlayView *playView;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    YFPlayView *playView= [YFPlayView cusstomPlayView];
    playView.frame = self.imgV.bounds;
    [self.imgV addSubview:playView];
    self.playView = playView;
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *pathUrl = [NSURL URLWithString:@"http://127.0.0.1/resource/SHtHAPH.mp4"];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:pathUrl];
    self.playView.playerItem = item;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

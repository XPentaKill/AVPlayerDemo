//
//  YFPlayView.m
//  自由练习
//
//  Created by 莘英发 on 2018/5/8.
//  Copyright © 2018年 莘英发. All rights reserved.
//

#import "YFPlayView.h"

@interface YFPlayView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageV;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPuseBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *fullBtn;

@property (nonatomic, strong)  AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

// 播放进度跟进
@property (nonatomic, strong) NSTimer *timeChange;

@end


@implementation YFPlayView



// 更新播放的时间
- (void)timeChanging{
    NSTimeInterval allTime = CMTimeGetSeconds(self.playerItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.playerItem.currentTime);
    self.timeLabel.text = [self stringWithDurationTime:allTime currentTime:currentTime];
    self.slider.value = currentTime/allTime;
}

- (NSString *)stringWithDurationTime:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime{
    
    NSInteger dMin = (NSInteger)duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = (NSInteger)currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    return [NSString stringWithFormat:@"%ld:%ld/%ld:%ld", cMin, cSec, dMin, dSec];
    
}


// 初始化一些设置
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.player = [[AVPlayer alloc] init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bgImageV.bounds;
    [self.bgImageV.layer addSublayer:self.playerLayer];
    
    // 设置滑块的图片
    [self.slider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    self.slider.value = 0.00;
    
    [self removeTimer];
    self.playOrPuseBtn.selected = YES;
}

+ (instancetype)cusstomPlayView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"YFPlayView" owner:self options:nil].firstObject;
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem{
    _playerItem = playerItem;
    
    if (!playerItem) {
        NSLog(@"没有播放资源");
        return;
    }
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    
    // 自动播放
    [self.player play];
    
    // 开启计时器
    [self addTimer];
}

// 播放暂停按钮的点击事件
- (IBAction)playOrPuseBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
    }else{
        [self.player pause];
    }
    [self removeTimer];
    [self addTimer];
}

- (void)addTimer{
    if (!_timeChange) {
        _timeChange = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChanging) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timeChange forMode:NSRunLoopCommonModes];
    }
}

- (void)removeTimer{
    [self.timeChange invalidate];
    self.timeChange = nil;
}


- (IBAction)startSlide:(UISlider *)sender {
    [self removeTimer];
   
}

- (IBAction)slider:(UISlider *)sender {
     [self addTimer];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.playerItem.duration) * sender.value;
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.player play];
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    NSTimeInterval duration = CMTimeGetSeconds(self.playerItem.duration);
    NSTimeInterval current = duration * sender.value;
    self.timeLabel.text = [self stringWithDurationTime:duration currentTime:current];
    
}


@end

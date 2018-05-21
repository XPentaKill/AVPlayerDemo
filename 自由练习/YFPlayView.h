//
//  YFPlayView.h
//  自由练习
//
//  Created by 莘英发 on 2018/5/8.
//  Copyright © 2018年 莘英发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface YFPlayView : UIView

// 资源
@property (nonatomic, strong)  AVPlayerItem *playerItem;

+ (instancetype)cusstomPlayView;

@end

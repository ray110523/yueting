//
//  PlayViewController.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioStreamer;

@class ChannelDetailModel;

@interface PlayViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UIImageView *picView;
@property (strong, nonatomic) IBOutlet UILabel *readLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIButton *preBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) ChannelDetailModel *model;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL pause;
@property (nonatomic, assign) int audioLength;
@property (nonatomic, assign) int totalLength;
@property (nonatomic, strong) NSTimer *timerCount;

@property (nonatomic, strong) AudioStreamer *audioStreamer;
@property (nonatomic, strong) NSTimer *progressTimer;

+ (PlayViewController *)defaultPlayVC;

- (void)refreshLayout;
- (void)creatStreamer;
- (void)destroyStreamer;

@end

//
//  PlayViewController.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "PlayViewController.h"
#import "UIImageView+WebCache.h"
#import "ChannelDetailModel.h"
#import "ChannelPlayInfoModel.h"
#import "ChannelUserInfoModel.h"
#import "Frames.h"
#import "AudioStreamer.h"

@interface PlayViewController ()
{
    float current;
}
@end

@implementation PlayViewController

+ (PlayViewController *)defaultPlayVC
{
    static PlayViewController *playVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playVC = [[PlayViewController alloc] init];
    });
    return playVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.picView.layer.borderWidth = 5;
//    self.picView.layer.borderColor = [UIColor blackColor].CGColor;
    self.pause = YES;
    self.picView.layer.cornerRadius = (SCREENWIDTH - 80) / 2;
    self.picView.clipsToBounds = YES;
    [NSTimer scheduledTimerWithTimeInterval:1.6 target:self selector:@selector(rotation) userInfo:nil repeats:YES];
    [self creatStreamer];
    current = 1;
    [self.progressView setTintColor:[UIColor orangeColor]];
    [self.progressView setTrackTintColor:[UIColor blueColor]];
    [self refreshLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)refreshLayout
{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:_model.playInfo.imgUrl] placeholderImage:nil];
    self.readLabel.text = _model.userinfo.uname;
    self.titleLabel.text = _model.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Progress

- (void)playing
{
    if (self.audioStreamer.progress == 0.0) {
        [self destroyStreamer];
        [self creatStreamer];
        [self.audioStreamer start];
    }
    if (self.audioStreamer.duration > 0.0) {
        NSLog(@"%lf", self.audioStreamer.progress);
        int cc = self.audioStreamer.duration - self.audioStreamer.progress;
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%02d", cc / 60, cc % 60];
        self.progressView.progress = self.audioStreamer.progress / self.audioStreamer.duration;
        if (!(self.audioStreamer.duration > self.audioStreamer.progress) && self.index < self.dataArray.count - 1) {
            [self next];
        }
    }
//    self.audioLength--;
    
}

#pragma mark - ButtonsClick
- (IBAction)returnBtn:(id)sender {
//    [self.timerCount invalidate];
//    self.timerCount = nil;
//    [self destroyStreamer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)playBtn:(id)sender {
    if (!_pause) {
        [self.audioStreamer pause];
        NSLog(@"%lf", self.audioStreamer.duration);
        [self.timerCount invalidate];
        self.timerCount = nil;
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"TingPlayerPlay"] forState:UIControlStateNormal];
        _pause = YES;
    } else {
        if (_dataArray) {
            [self creatStreamer];
            [self.audioStreamer start];
            [self.playBtn setBackgroundImage:[UIImage imageNamed:@"TingPlayerPause"] forState:UIControlStateNormal];
            
            [self.timerCount invalidate];
            self.timerCount = nil;
            self.timerCount = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playing) userInfo:nil repeats:YES];
            _pause = NO;
        }
        
       
    }

}

- (IBAction)preBtn:(id)sender {
    if (_dataArray) {
        [self pre];
            }
}

- (void)pre
{
    if (self.index > 0) {
        self.index -= 1;
        self.model = _dataArray[self.index];
        [self refreshLayout];
        [_audioStreamer stop];
        [self.timerCount invalidate];
        self.timerCount = nil;
        current = 0;
        self.picView.transform = CGAffineTransformRotate(self.view.transform, 0);
        [self destroyStreamer];
        [self creatStreamer];
        if (!_pause) {
            [self.audioStreamer start];
            self.timerCount = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playing) userInfo:nil repeats:YES];
        }
    }

}

- (IBAction)nextBtn:(id)sender {
    if (_dataArray) {
        
        [self next];
    }
}

- (void)next
{
    if (self.index < _dataArray.count) {
        self.index += 1;
        self.model = _dataArray[self.index];
        [self refreshLayout];
        [self.timerCount invalidate];
        self.timerCount = nil;
        current = 0;
        self.picView.transform = CGAffineTransformRotate(self.view.transform, 0);
        [_audioStreamer stop];
        [self destroyStreamer];
        [self creatStreamer];
        if (!_pause) {
            [self.audioStreamer start];
            self.timerCount = self.timerCount = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playing) userInfo:nil repeats:YES];
        }
    }
}

#pragma mark - Animate

- (void)rotation
{
    [UIView beginAnimations:@"旋转图片" context:NULL];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.picView.transform = CGAffineTransformRotate(self.picView.transform, M_PI_4);
    [UIView commitAnimations];
}

#pragma mark - AudioStreamer

- (void)creatStreamer
{
    if (_audioStreamer) {
        return;
    }
    [self destroyStreamer];
    self.audioStreamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:_model.musicUrl]];
    [self.progressView setProgress:self.audioStreamer.duration animated:YES];
    
}

- (void)destroyStreamer
{
    if (_audioStreamer) {
        [_progressTimer invalidate];
        _progressTimer = nil;
        [_audioStreamer stop];
        _audioStreamer = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  OneViewController.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-6.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "OneViewController.h"
#import "TitleView.h"
#import "TopScrollView.h"
#import "ArticleScrollView.h"
#import "QuestionView.h"
#import "StaffView.h"
#import "Frames.h"

@interface OneViewController () <TitleViewDelegate>
{
    BOOL flagTop;
    BOOL flagArt;
    BOOL flagQue;
    BOOL flagStf;
}

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.staffView = [[StaffView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 -TABBARHEIGHT)];
    self.staffView.viewController = self;
    self.staffView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:_staffView];
    
    self.questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 -TABBARHEIGHT)];
    self.questionView.viewController = self;
    _questionView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:_questionView];
    
    self.articleScrollView = [[ArticleScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    self.articleScrollView.viewController = self;
    _articleScrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:_articleScrollView];
    
    self.topScrollView = [[TopScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    self.topScrollView.viewController = self;
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:_topScrollView];
    
    self.titleArray = [NSMutableArray arrayWithArray:@[@"首页", @"文章", @"问题", @"东西"]];
    self.titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT) titleArray:_titleArray];
    self.titleView.delegate = self;
//    self.titleView.frame = CGRectMake(0, 0, SCREENWIDTH / 2, NAVBARHEIGHT);
//    self.titleView.center = CGPointMake(SCREENWIDTH / 2, 0);
    self.navigationItem.titleView = _titleView;
//    [self.view addSubview:_titleView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_queue_t customQueue = dispatch_queue_create("com.Ray.custom", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(customQueue, ^{
        [self.topScrollView getData];
    });
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"首页"]) {
        [self.view bringSubviewToFront:_topScrollView];
        if (!flagTop) {
            dispatch_queue_t customQueue = dispatch_queue_create("com.Ray.custom", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(customQueue, ^{
                [self.topScrollView getData];
            });
            flagTop = YES;
        }
    } else if ([button.titleLabel.text isEqualToString:@"文章"]) {
        [self.view bringSubviewToFront:_articleScrollView];
        if (!flagArt) {
            dispatch_queue_t customQueue = dispatch_queue_create("com.Ray.custom", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(customQueue, ^{
                [self.articleScrollView getData];
            });
            flagArt = YES;
        }
    } else if ([button.titleLabel.text isEqualToString:@"问题"]) {
        [self.view bringSubviewToFront:_questionView];
        if (!flagQue) {
            dispatch_queue_t customQueue = dispatch_queue_create("com.Ray.custom", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(customQueue, ^{
                [self.questionView getData];
            });
            flagQue = YES;
        }
    } else {
        [self.view bringSubviewToFront:_staffView];
        if (!flagStf) {
            dispatch_queue_t customQueue = dispatch_queue_create("com.Ray.custom", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(customQueue, ^{
                [self.staffView getData];
            });
            flagStf = YES;
        }
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

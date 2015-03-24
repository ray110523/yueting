//
//  OneViewController.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-6.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleView, TopScrollView, ArticleScrollView, QuestionView, StaffView;

@interface OneViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) TopScrollView *topScrollView;
@property (nonatomic, strong) ArticleScrollView *articleScrollView;
@property (nonatomic, strong) QuestionView *questionView;
@property (nonatomic, strong) StaffView *staffView;

@end

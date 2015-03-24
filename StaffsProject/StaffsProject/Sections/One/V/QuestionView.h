//
//  QuestionView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "MainScrollView.h"

@class QuestionModel, NiceView, OneViewController;

@interface QuestionView : MainScrollView

@property (nonatomic, strong) UIImageView *questionIcon;
@property (nonatomic, strong) UILabel *qTitleLabel;
@property (nonatomic, strong) UILabel *qContentLabel;

@property (nonatomic, strong) UIImageView *secondLineView;

@property (nonatomic, strong) UIImageView *answerIcon;
@property (nonatomic, strong) UILabel *aTitleLabel;
@property (nonatomic, strong) UILabel *aContentLabel;

@property (nonatomic, strong) NiceView *niceView;

@property (nonatomic, strong) QuestionModel *model;

@property (nonatomic, strong) OneViewController *viewController;

- (void)getData;

@end

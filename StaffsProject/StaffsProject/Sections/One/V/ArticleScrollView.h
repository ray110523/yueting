//
//  ArticleScrollView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "MainScrollView.h"

@class ArticleModel, NiceView, OneViewController;

@interface ArticleScrollView : MainScrollView

@property (nonatomic, strong) ArticleModel *model;

@property (nonatomic, strong) UILabel *artNameLabel;
@property (nonatomic, strong) UILabel *artAuthorNameLabel;
//@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *editorLabel;

@property (nonatomic, strong) NiceView *niceView;
//@property (nonatomic, strong) UIImageView *heartView;
//@property (nonatomic, strong) UILabel *niceCountLabel;

@property (nonatomic, strong) UIImageView *secondLineView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *webNameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;

@property (nonatomic, strong) OneViewController *viewController;

- (void)getData;

@end

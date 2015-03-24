//
//  TopScrollView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "MainScrollView.h"

@class TopModel, NiceView, OneViewController;

@interface TopScrollView : MainScrollView

@property (nonatomic, strong) TopModel *model;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) NiceView *niceView;
//@property (nonatomic, strong) UIImageView *heartView;
//@property (nonatomic, strong) UILabel *niceCountLabel;

@property (nonatomic, strong) OneViewController *viewController;

- (void)getData;

@end

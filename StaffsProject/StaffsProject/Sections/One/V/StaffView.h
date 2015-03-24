//
//  StaffView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-10.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "MainScrollView.h"

@class StaffModel, OneViewController;

@interface StaffView : MainScrollView

@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) StaffModel *model;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) OneViewController *viewController;

- (void)getData;

@end

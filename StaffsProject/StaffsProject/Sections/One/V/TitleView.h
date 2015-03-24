//
//  TitleView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>

- (void)clickButton:(UIButton *) button;

@end

@interface TitleView : UIView

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, weak) id<TitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray;

@end

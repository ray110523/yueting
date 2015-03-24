//
//  MainScrollView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN 10
#define LABELHEIGHT 20
#define LINEHEIGHT 2

@protocol MainScrollViewDelegate <NSObject>

- (void)refreshWithSwipeLeft;
- (void)refreshWithSwipeRight;


@end

@interface MainScrollView : UIScrollView

@property (nonatomic, strong) UILabel *leftUpLabel;
@property (nonatomic, strong) UILabel *rightUpLabel;
@property (nonatomic, strong) UIImageView *lineView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, weak) id <MainScrollViewDelegate> swipeDelegate;

- (CGFloat)resetLabelHeight:(UILabel *)label string:(NSString *)string font:(CGFloat)font;
- (CGFloat)resetLabelHeight:(UILabel *)label attributesString:(NSAttributedString *)string font:(CGFloat)font;

@end

//
//  TitleView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "TitleView.h"
#import "Frames.h"

@implementation TitleView

//- (id)initWithFrame:TitleArray:(NSMutableArray *)titleArray
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray
{
//    if (self = [super initWithFrame:CGRectMake(0, STATUSBARHEIGHT + NAVBARHEIGHT, SCREENWIDTH, NAVBARHEIGHT)]) {
//        self.backgroundColor = [UIColor colorWithRed:190 / 255. green:190 / 255. blue:190 / 255. alpha:0.8];
    if (self = [super initWithFrame:frame]) {
        self.titleArray = [NSMutableArray array];
        self.lineView = [[UIView alloc] init];
        self.titleArray = titleArray;
        [self setButtons];
    }
    return self;
}

- (void)setButtons
{
    self.btnArray = [[NSMutableArray alloc] init];
    if (_titleArray.count) {
        CGFloat width = SCREENWIDTH / _titleArray.count;
        self.lineView.frame = CGRectMake(0, NAVBARHEIGHT - 5, width, 5);
        self.lineView.backgroundColor = [UIColor colorWithRed:80 / 255. green:180 / 255. blue:240 / 255. alpha:1];
        [self addSubview:_lineView];
        for (int i = 0; i < _titleArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:_titleArray[i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
            if (i == 0) {
                [button setTitleColor:[UIColor colorWithRed:80 / 255. green:180 / 255. blue:240 / 255. alpha:1] forState:UIControlStateNormal];
            } else {
                [button setTitleColor:[UIColor colorWithRed:190 / 255. green:190 / 255. blue:190 / 255. alpha:0.8] forState:UIControlStateNormal];
            }
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            button.tag = 100 + i;
            button.frame = CGRectMake(width * i, 0, width, NAVBARHEIGHT);
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArray addObject:button];
            [self addSubview:[_btnArray lastObject]];
        }
    }
}

- (void)buttonClicked:(UIButton *)button
{
    //    [button setTitleColor:[UIColor colorWithRed:50 / 255. green:100 / 255. blue:250 / 255. alpha:1] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.frame = CGRectMake((SCREENWIDTH / _btnArray.count) * (button.tag - 100), NAVBARHEIGHT - 5, SCREENWIDTH / _btnArray.count, 5);
        for (UIButton *btn in _btnArray) {
            [btn setTitleColor:[UIColor colorWithRed:190 / 255. green:190 / 255. blue:190 / 255. alpha:0.8] forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor colorWithRed:80 / 255. green:180 / 255. blue:240 / 255. alpha:1] forState:UIControlStateNormal];
        
    }];
    [self.delegate clickButton:button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

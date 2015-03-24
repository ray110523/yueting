//
//  NoMoreView.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "NoMoreView.h"
#import "Frames.h"

@implementation NoMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BoardcastListCellMask"]];
        self.imageView.frame = CGRectMake(SCREENWIDTH / 2 - 100, self.bounds.size.height - 30, 200, 30);
        [self addSubview:_imageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2 - 100, self.bounds.size.height - 30, 200, 30)];
        self.textLabel.text = @"没有更多电台啦";
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:_textLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

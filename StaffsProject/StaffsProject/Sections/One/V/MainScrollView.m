//
//  MainScrollView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//



#import "MainScrollView.h"
#import "UIImageView+WebCache.h"
#import "Frames.h"

@implementation MainScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.leftUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, SCREENWIDTH / 2 - MARGIN, LABELHEIGHT)];
        self.leftUpLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_leftUpLabel];
        
        self.rightUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2, MARGIN, SCREENWIDTH / 2 - MARGIN, LABELHEIGHT)];
        self.rightUpLabel.textColor = [UIColor lightGrayColor];
        self.rightUpLabel.font = [UIFont systemFontOfSize:13];
        self.rightUpLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightUpLabel];
        
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, LABELHEIGHT + MARGIN, SCREENWIDTH - MARGIN * 2, LINEHEIGHT)];
        _lineView.image = [UIImage imageNamed:@"dateline"];
        [self addSubview:_lineView];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView.center = CGPointMake(self.center.x, 200);
        self.activityView.color = [UIColor lightGrayColor];
        [self addSubview:_activityView];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
    }
    return self;
}

- (CGFloat)resetLabelHeight:(UILabel *)label string:(NSString *)string font:(CGFloat)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(label.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    CGRect frame = label.frame;
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
    
    return rect.size.height;
}

- (CGFloat)resetLabelHeight:(UILabel *)label attributesString:(NSAttributedString *)string font:(CGFloat)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(label.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGRect frame = label.frame;
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
    
    return rect.size.height;
}


- (void)swipeLeft
{
    [self.swipeDelegate refreshWithSwipeLeft];
}

- (void)swipeRight
{
    [self.swipeDelegate refreshWithSwipeRight];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

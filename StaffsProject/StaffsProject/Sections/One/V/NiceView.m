//
//  NiceView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-10.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "NiceView.h"
#import "Frames.h"

@implementation NiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x - 90 + frame.size.width, frame.origin.y, 90, frame.size.height)]) {
        self.heartView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, 0, LABELHEIGHT, LABELHEIGHT)];
        self.heartView.image = [UIImage imageNamed:@"home_like"];
        [self addSubview:_heartView];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 60, LABELHEIGHT)];
        self.countLabel.textColor = [UIColor colorWithRed:160 / 255. green:160 / 255. blue:160 / 255. alpha:0.8];
        self.countLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.countLabel];
    }
    return self;
}

- (void)setNumber:(NSString *)number
{
    _number = number;
    self.countLabel.text = number;
    CGRect rect = [number boundingRectWithSize:CGSizeMake(0, 13) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    CGRect frame =  _countLabel.frame;
    CGRect frameSelf = self.frame;
    CGFloat w = 0;
    if (rect.size.width > frame.size.width) {
        w = rect.size.width - frame.size.width;
        self.frame = CGRectMake(frameSelf.origin.x - w, frameSelf.origin.y, frameSelf.size.width + w, frameSelf.size.height);
    } else {
        w = frame.size.width - rect.size.width;
        self.frame = CGRectMake(frameSelf.origin.x + w, frameSelf.origin.y, frameSelf.size.width - w, frameSelf.size.height);
    }
    _countLabel.frame = CGRectMake(self.frame.size.width - rect.size.width, 0, rect.size.width, LABELHEIGHT);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

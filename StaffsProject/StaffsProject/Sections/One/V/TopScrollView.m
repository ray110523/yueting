//
//  TopScrollView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#define DAYLABELHEIGHT 35

#import "TopScrollView.h"
#import "OneViewController.h"
#import "WebViewController.h"
#import "NiceView.h"
#import "Frames.h"
#import "TopModel.h"
#import "DataParse.h"
#import "UIImageView+WebCache.h"


@interface TopScrollView () <MainScrollViewDelegate>
{
    int row;
    NSString *date;
}
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation TopScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor orangeColor];
        self.swipeDelegate = self;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView.center = CGPointMake(self.center.x, 200);
        self.activityView.color = [UIColor lightGrayColor];
        [self addSubview:self.activityView];
        
        row = 1;
        //求出当前日期
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *currentDate = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
        int year = [currentDate year];
        int month = [currentDate month];
        int day = [currentDate day];
        date = [NSString stringWithFormat:@"%d-%02d-%02d", year, month, day];
//        NSLog(@"%@", date);
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, self.lineView.frame.origin.y + LINEHEIGHT + MARGIN, SCREENWIDTH - MARGIN * 2, (SCREENWIDTH - MARGIN * 2) / 3 * 2)];
        [self addSubview:_imageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _imageView.frame.origin.y + _imageView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_nameLabel];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        _authorLabel.font = [UIFont systemFontOfSize:15];
        _authorLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_authorLabel];
        
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2, _authorLabel.frame.origin.y + _authorLabel.frame.size.height + MARGIN, (SCREENWIDTH - MARGIN * 4) / 4, DAYLABELHEIGHT)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:30];
        _dayLabel.textColor = [UIColor colorWithRed:80 / 255. green:200 / 255. blue:240 / 255. alpha:1];
        [self addSubview:_dayLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2, _dayLabel.frame.origin.y + _dayLabel.frame.size.height, (SCREENWIDTH - MARGIN * 4) / 4, LABELHEIGHT)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_dateLabel];
        
        self.backImageView = [[UIImageView alloc] init];
        [self addSubview:_backImageView];
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 3 + _dayLabel.frame.size.width, _dayLabel.frame.origin.y, (SCREENWIDTH - MARGIN * 4) / 4 * 3, 50)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor whiteColor];
        [self addSubview:_textLabel];
        
        self.niceView = [[NiceView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 80, _textLabel.frame.origin.y + _textLabel.frame.size.height + MARGIN * 2, 80, LABELHEIGHT)];
        UIImage *img = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:self.niceView.frame.size.width / 2 topCapHeight:0];
        [_niceView setImage:img];
        [self addSubview:_niceView];
    }
    return self;
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将要进入网页版" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
//}

- (void)getData
{
    // http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate=2015-03-12&strRow=1
    
    [self.activityView startAnimating];
    __block TopScrollView *blockSelf = self;
    DataParse *dataParse = [[DataParse alloc] init];
    [dataParse setBlock:^(id object) {
        if ([[object valueForKey:@"result"] isEqualToString:@"FAIL"]) {
            row -= 1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
            blockSelf.model = [[TopModel alloc] init];
            [blockSelf.model setValuesForKeysWithDictionary:[object valueForKey:@"hpEntity"]];
            [blockSelf refreshDataWithModel:_model];
            [blockSelf.activityView stopAnimating];
            [blockSelf.activityView setHidesWhenStopped:YES];
        }
    }];
    [dataParse parseDataWithAPI:[NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate=%@&strRow=%d", date, row]];
}

- (void)refreshDataWithModel:(TopModel *)model
{
    self.leftUpLabel.text = _model.strHpTitle;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.strOriginalImgUrl] placeholderImage:nil];
    
    NSRange range = [_model.strAuthor rangeOfString:@"&"];
    NSInteger location = range.location;
    self.nameLabel.text = [_model.strAuthor substringToIndex:location];
    self.authorLabel.text = [_model.strAuthor substringFromIndex:location + 1];
    
    
    self.dayLabel.text = [_model.strMarketTime substringFromIndex:8];
    NSString *month = [_model.strMarketTime substringWithRange:NSMakeRange(5, 2)];
    NSString *year = [_model.strMarketTime substringToIndex:4];
    self.dateLabel.text = [[self numberToEnglish:month] stringByAppendingString:year];
    
    self.textLabel.text = _model.strContent;
    [self resetLabelHeight];
    UIImage *img = [[UIImage imageNamed:@"contBack"] stretchableImageWithLeftCapWidth:0 topCapHeight:25];
    self.backImageView.frame = CGRectMake(self.textLabel.frame.origin.x - 10, self.textLabel.frame.origin.y, self.textLabel.frame.size.width + 10, self.textLabel.frame.size.height);
    self.backImageView.image = img;

    
    self.niceView.number = _model.strPn;
    CGRect fr = self.niceView.frame;
    self.niceView.frame = CGRectMake(fr.origin.x, _textLabel.frame.origin.y + _textLabel.frame.size.height + MARGIN * 2, fr.size.width, fr.size.height);
    
    self.contentSize = CGSizeMake(SCREENWIDTH, _niceView.frame.origin.y + _niceView.frame.size.height + MARGIN * 2 + 64);
    
}

- (CGFloat)resetLabelHeight
{
    CGRect rect = [_model.strContent boundingRectWithSize:CGSizeMake(_textLabel.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    CGRect frame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
    
    return rect.size.height + MARGIN * 10 + LABELHEIGHT * 5 + _imageView.frame.size.height;
}

- (NSString *)numberToEnglish:(NSString *)month
{
    int m = [month intValue];
    switch (m) {
        case 1:
            return @"Jan.";
        case 2:
            return @"Feb.";
        case 3:
            return @"Mar.";
        case 4:
            return @"Apr.";
        case 5:
            return @"May.";
        case 6:
            return @"Jun.";
        case 7:
            return @"July.";
        case 8:
            return @"Aug.";
        case 9:
            return @"Sept.";
        case 10:
            return @"Oct.";
        case 11:
            return @"Nov.";
        case 12:
            return @"Dec.";
            
            
        default:
            return 0;
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = _model.sWebLk;
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
}


#pragma mark - MainScrollViewDelegate

- (void)refreshWithSwipeLeft
{
    
//    [_activityView startAnimating];
    row += 1;

        [self getData];

}

- (void)refreshWithSwipeRight
{
    if (row > 1) {
//        [_activityView startAnimating];
        row -= 1;

            [self getData];

    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已是最新数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

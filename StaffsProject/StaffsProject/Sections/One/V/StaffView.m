//
//  StaffView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-10.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//  http://bea.wufazhuce.com:7001/OneForWeb/one/o_f
//  strDate=2015-03-11&strRow=1
#import <c>
#import "StaffView.h"
#import "WebViewController.h"
#import "OneViewController.h"
#import "StaffModel.h"
#import "DataParse.h"
#import "NumToMonth.h"
#import "Frames.h"
#import "UIImageView+WebCache.h"

@interface StaffView () <MainScrollViewDelegate, UIAlertViewDelegate>
{
    int row;
    NSString *date;
}
@end

@implementation StaffView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.swipeDelegate = self;
        
        
        
        row = 1;
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *currentDate = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
        int year = [currentDate year];
        int month = [currentDate month];
        int day = [currentDate day];
        date = [NSString stringWithFormat:@"%d-%02d-%02d", year, month, day];
        
        self.model = [[StaffModel alloc] init];
        
        self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, self.lineView.frame.origin.y + self.lineView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, SCREENWIDTH - MARGIN * 2)];
        [self addSubview:_picView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.picView.frame.origin.y + self.picView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        [self addSubview:_titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return self;
    cmstep
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将要进入网页版" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
//}

- (void)getData
{
    [self.activityView startAnimating];
    DataParse *dataParse = [[DataParse alloc] init];
    __weak StaffView *blockSelf = self;
    [dataParse setBlock:^(id object) {
        if ([[object valueForKey:@"result"] isEqualToString:@"FAIL"]) {
            row -= 1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
            [blockSelf.model setValuesForKeysWithDictionary:[object valueForKey:@"entTg"]];
            [blockSelf refreshDataWithModel:blockSelf.model];
            [blockSelf.activityView stopAnimating];
            [blockSelf.activityView hidesWhenStopped];
        }
    }];
//    [dataParse parseDataWithAPI:[NSString stringWithFormat:@"http://bea.wufazhuce.com:7001/OneForWeb/one/o_f?strDate=%@&strRow=%d", date, row]];
    NSURL *url = [NSURL URLWithString:@"http://bea.wufazhuce.com:7001/OneForWeb/one/o_f"];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [[NSString stringWithFormat:@"strDate=%@&strRow=%d", date, row] dataUsingEncoding:NSUTF8StringEncoding];
    [dataParse parseDataWithRequest:mRequest];
}

- (void)refreshDataWithModel:(StaffModel *)model
{
    NSString *month = [NumToMonth numberToEnglish:[model.strTm substringWithRange:NSMakeRange(5, 2)]];
    NSString *day = [model.strTm substringFromIndex:8];
    NSString *year = [model.strTm substringToIndex:4];
    self.leftUpLabel.text = [NSString stringWithFormat:@"%@ %@,%@", month, day, year];
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:_model.strBu] placeholderImage:nil];
    self.titleLabel.text = model.strTt;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 10;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:model.strTc attributes:@{NSParagraphStyleAttributeName:paraStyle, NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.contentLabel.attributedText = aString;
    [self resetLabelHeight:_contentLabel attributesString:aString font:15];
    
    self.contentSize = CGSizeMake(SCREENWIDTH, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + MARGIN * 2);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = _model.strWu;
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
}


#pragma mark - MainScrollViewDelegate

- (void)refreshWithSwipeLeft
{
    row += 1;

        [self getData];

}

- (void)refreshWithSwipeRight
{
    if (row > 1) {
        row -= 1;

            [self getData];

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

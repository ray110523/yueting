//
//  QuestionView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//  http://bea.wufazhuce.com:7001/OneForWeb/one/getQ_N
//  strDate=2015-03-11&strRow=2

#import "QuestionView.h"
#import "OneViewController.h"
#import "WebViewController.h"
#import "NiceView.h"
#import "QuestionModel.h"
#import "DataParse.h"
#import "NumToMonth.h"
#import "QuestionModel.h"
#import "Frames.h"

@interface QuestionView () <MainScrollViewDelegate>
{
    int row;
    NSString *date;
}

@end

@implementation QuestionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.swipeDelegate = self;
        self.model = [[QuestionModel alloc] init];
        
        row = 1;
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *currentDate = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
        int year = [currentDate year];
        int month = [currentDate month];
        int day = [currentDate day];
        date = [NSString stringWithFormat:@"%d-%02d-%02d", year, month, day];
        
        self.questionIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, self.lineView.frame.origin.y + self.lineView.frame.size.height + MARGIN, 30, 30)];
        [self.questionIcon setImage:[UIImage imageNamed:@"que_img"]];
        [self addSubview:_questionIcon];
        
        self.qTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + MARGIN * 2, _questionIcon.frame.origin.y, SCREENWIDTH - MARGIN * 3 - 30, LABELHEIGHT)];
        self.qTitleLabel.font = [UIFont systemFontOfSize:15];
        self.qTitleLabel.numberOfLines = 0;
        [self addSubview:_qTitleLabel];
        
        self.qContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.questionIcon.frame.origin.y + self.questionIcon.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.qContentLabel.font = [UIFont systemFontOfSize:15];
        self.qContentLabel.numberOfLines = 0;
        [self addSubview:_qContentLabel];
        
        
        self.secondLineView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, self.qContentLabel.frame.origin.y + self.qContentLabel.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LINEHEIGHT)];
        self.secondLineView.image = [UIImage imageNamed:@"dateline"];
        [self addSubview:_secondLineView];
        
        self.answerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, self.secondLineView.frame.origin.y + self.secondLineView.frame.size.height + MARGIN, 30, 30)];
        self.answerIcon.image = [UIImage imageNamed:@"ans_img"];
        [self addSubview:_answerIcon];
        
        self.aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2 + 30, self.answerIcon.frame.origin.y, SCREENWIDTH - MARGIN * 3 - 30, LABELHEIGHT)];
        self.aTitleLabel.font = [UIFont systemFontOfSize:15];
        self.aTitleLabel.numberOfLines = 0;
        [self addSubview:_aTitleLabel];
        
        self.aContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _answerIcon.frame.origin.y + _answerIcon.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.aContentLabel.font = [UIFont systemFontOfSize:15];
        self.aContentLabel.numberOfLines = 0;
        [self addSubview:_aContentLabel];
        
        self.niceView = [[NiceView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 80, _aContentLabel.frame.origin.y + _aContentLabel.frame.size.height + MARGIN * 2, 80, 20)];
        UIImage *img = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:self.niceView.frame.size.width / 2 topCapHeight:0];
        [self.niceView setImage:img];
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
    [self.activityView startAnimating];
    DataParse *dataParse = [[DataParse alloc] init];
    __weak QuestionView *blockSelf = self;
    [dataParse setBlock:^(id object) {
        if ([[object valueForKey:@"result"] isEqualToString:@"FAIL"]) {
            row -= 1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
            blockSelf.model = [[QuestionModel alloc] init];
            [blockSelf.model setValuesForKeysWithDictionary:[object valueForKey:@"questionAdEntity"]];
            [blockSelf refreshDataWithModel];
            [blockSelf.activityView stopAnimating];
            [blockSelf.activityView hidesWhenStopped];
        }
    }];
//    [dataParse parseDataWithAPI:[NSString stringWithFormat:@"http://bea.wufazhuce.com:7001/OneForWeb/one/getQ_N?strDate=%@&strRow=%d", date, row]];
    NSURL *url = [NSURL URLWithString:@"http://bea.wufazhuce.com:7001/OneForWeb/one/getQ_N"];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [[NSString stringWithFormat:@"strDate=%@&strRow=%d", date, row] dataUsingEncoding:NSUTF8StringEncoding];
    [dataParse parseDataWithRequest:mRequest];
}

- (void)refreshDataWithModel
{
    NSString *month = [NumToMonth numberToEnglish:[self.model.strQuestionMarketTime substringWithRange:NSMakeRange(5, 2)]];
    NSString *day = [self.model.strQuestionMarketTime substringFromIndex:8];
    NSString *year = [self.model.strQuestionMarketTime substringToIndex:4];
    self.leftUpLabel.text = [NSString stringWithFormat:@"%@ %@,%@", month, day, year];
    
    self.qTitleLabel.text = self.model.strQuestionTitle;
    [self resetLabelHeight:self.qTitleLabel string:self.model.strQuestionTitle font:15];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:10];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:self.model.strQuestionContent attributes:@{NSParagraphStyleAttributeName:paraStyle, NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.qContentLabel.attributedText = aString;
    [self resetLabelHeight:self.qContentLabel attributesString:aString font:15];
    
    self.aTitleLabel.text = self.model.strAnswerTitle;
    [self resetLabelHeight:self.aTitleLabel string:self.model.strAnswerTitle font:15];
    
    NSString *text = [self.model.strAnswerContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    text = [text stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
    NSMutableParagraphStyle *paraStyleA = [[NSMutableParagraphStyle alloc] init];
    paraStyleA.lineSpacing = 10;
    NSMutableAttributedString *aStringA = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle, NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.aContentLabel.attributedText = aStringA;
    [self resetLabelHeight:self.aContentLabel attributesString:aStringA font:15];
    
    self.niceView.number = self.model.strPraiseNumber;
    
    CGRect fr = self.qContentLabel.frame;
    self.qContentLabel.frame = CGRectMake(fr.origin.x, self.questionIcon.frame.origin.y + self.questionIcon.frame.size.height + MARGIN, fr.size.width, fr.size.height);
    fr = self.secondLineView.frame;
    self.secondLineView.frame = CGRectMake(fr.origin.x, self.qContentLabel.frame.origin.y + self.qContentLabel.frame.size.height + MARGIN, fr.size.width, fr.size.height);
    fr = self.answerIcon.frame;
    self.answerIcon.frame = CGRectMake(fr.origin.x, self.secondLineView.frame.origin.y + self.secondLineView.frame.size.height + MARGIN, fr.size.width, fr.size.height);
    fr = self.aTitleLabel.frame;
    self.aTitleLabel.frame = CGRectMake(fr.origin.x, self.answerIcon.frame.origin.y, fr.size.width, fr.size.height);
    fr = self.aContentLabel.frame;
    self.aContentLabel.frame = CGRectMake(fr.origin.x, _answerIcon.frame.origin.y + _answerIcon.frame.size.height + MARGIN, fr.size.width, fr.size.height);
    fr = self.niceView.frame;
    self.niceView.frame = CGRectMake(fr.origin.x, self.aContentLabel.frame.size.height + self.aContentLabel.frame.origin.y, fr.size.width, fr.size.height);
    
    self.contentSize = CGSizeMake(SCREENWIDTH, _niceView.frame.origin.y + _niceView.frame.size.height + MARGIN * 2);
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

//
//  ArticleScrollView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ArticleScrollView.h"
#import "OneViewController.h"
#import "WebViewController.h"
#import "NiceView.h"
#import "ArticleModel.h"
#import "Frames.h"
#import "DataParse.h"
#import "NumToMonth.h"

@interface ArticleScrollView () <MainScrollViewDelegate>
{
    int row;
    NSString *date;
}


@end

@implementation ArticleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.swipeDelegate = self;

        
        
        
        row = 1;
        //求出当前日期
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *currentDate = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
        int year = [currentDate year];
        int month = [currentDate month];
        int day = [currentDate day];
        date = [NSString stringWithFormat:@"%d-%02d-%02d", year, month, day];
        
        self.artNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.lineView.frame.origin.y + self.lineView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, 30)];
        _artNameLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_artNameLabel];
        
        self.artAuthorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.artNameLabel.frame.origin.y + self.artNameLabel.frame.size.height, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.artAuthorNameLabel.font = [UIFont systemFontOfSize:12];
        self.artAuthorNameLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_artAuthorNameLabel];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, self.artAuthorNameLabel.frame.origin.y + self.authorNameLabel.frame.size.height + MARGIN * 2, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        
        self.editorLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _textLabel.frame.origin.y + _textLabel.frame.size.height + MARGIN * 2, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        _editorLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_editorLabel];
        
        self.niceView = [[NiceView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 80, self.editorLabel.frame.origin.y + self.editorLabel.frame.size.height + MARGIN, 80, LABELHEIGHT)];
        UIImage *img = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:self.niceView.frame.size.width / 2 topCapHeight:0];
        [self.niceView setImage:img];
        [self addSubview:_niceView];
        
        self.secondLineView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, _niceView.frame.origin.y + _niceView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LINEHEIGHT)];
        _secondLineView.image = [UIImage imageNamed:@"dateline"];
        [self addSubview:_secondLineView];
        
        self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _secondLineView.frame.origin.y + _secondLineView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, 30)];
        _authorNameLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_authorNameLabel];
        
        self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _authorNameLabel.frame.origin.y + _authorNameLabel.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT)];
        self.introduceLabel.font = [UIFont systemFontOfSize:15];
        self.introduceLabel.numberOfLines = 0;
        [self addSubview:_introduceLabel];
        
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
    __block ArticleScrollView *blockSelf = self;
    [dataParse setBlock:^(id object) {
        if ([[object valueForKey:@"result"] isEqualToString:@"FAIL"]) {
            row -= 1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
        blockSelf.model = [[ArticleModel alloc] init];
        [blockSelf.model setValuesForKeysWithDictionary:[object valueForKey:@"contentEntity"]];
        [blockSelf refreshData];
        [blockSelf.activityView stopAnimating];
        [blockSelf.activityView hidesWhenStopped];
        }
    }];
    [dataParse parseDataWithAPI:[NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate=%@&strRow=%d&strMS=1", date, row]];
}

- (void)refreshData
{
    NSString *year = [_model.strContMarketTime substringToIndex:4];
    NSString *month = [NumToMonth numberToEnglish:[_model.strContMarketTime substringWithRange:NSMakeRange(5, 2)]];
    NSString *day = [_model.strContMarketTime substringFromIndex:8];
    self.leftUpLabel.text = [NSString stringWithFormat:@"%@ %@,%@", month, day, year];
    
    self.rightUpLabel.text = [NSString stringWithFormat:@"阅读:%@", _model.sRdNum];
    
    self.artNameLabel.text = _model.strContTitle;
    self.artAuthorNameLabel.text = _model.strContAuthor;
    
    NSString *text = [_model.strContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
/**********************/
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.textLabel.attributedText = attString;

    CGRect fram = self.textLabel.frame;
    CGRect rec = [attString boundingRectWithSize:CGSizeMake(self.textLabel.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    self.textLabel.frame = CGRectMake(MARGIN, fram.origin.y, fram.size.width, rec.size.height);
 /***************************/
    
    self.editorLabel.frame = CGRectMake(MARGIN, _textLabel.frame.origin.y + _textLabel.frame.size.height + MARGIN * 2, SCREENWIDTH - MARGIN * 2, LABELHEIGHT);
    self.editorLabel.text = _model.strContAuthorIntroduce;
    self.niceView.number = _model.strPraiseNumber;
    self.niceView.frame = CGRectMake(self.niceView.frame.origin.x, self.editorLabel.frame.origin.y + self.editorLabel.frame.size.height + MARGIN, self.niceView.frame.size.width, LABELHEIGHT);
    self.secondLineView.frame = CGRectMake(MARGIN, _niceView.frame.origin.y + _niceView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LINEHEIGHT);
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", _model.strContAuthor, _model.sWbN] attributes:@{}];
    NSInteger loc = _model.strContAuthor.length;
    NSInteger len = _model.sWbN.length;
    [aString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(loc, len)];
    self.authorNameLabel.frame = CGRectMake(MARGIN, _secondLineView.frame.origin.y + _secondLineView.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, 30);
    self.authorNameLabel.attributedText = aString;
    
    self.introduceLabel.frame = CGRectMake(MARGIN, _authorNameLabel.frame.origin.y + _authorNameLabel.frame.size.height + MARGIN, SCREENWIDTH - MARGIN * 2, LABELHEIGHT);
    self.introduceLabel.text = _model.sAuth;
    [self resetLabelHeight:self.introduceLabel string:_model.sAuth font:15];
    
    
    self.contentSize = CGSizeMake(SCREENWIDTH, _introduceLabel.frame.origin.y + _introduceLabel.frame.size.height + MARGIN + 64);
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

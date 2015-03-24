//
//  ArticleModel.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-8.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, strong) NSString *strContMarketTime; // 日期
@property (nonatomic, strong) NSString *sRdNum;   //阅读数
@property (nonatomic, strong) NSString *strContTitle;    //文章题目
@property (nonatomic, strong) NSString *strContAuthor;    //文章作者
@property (nonatomic, strong) NSString *strContent;      //文章正文
@property (nonatomic, strong) NSString *strContAuthorIntroduce; //编辑
@property (nonatomic, strong) NSString *strPraiseNumber;   //点赞数
@property (nonatomic, strong) NSString *sWbN;   //网名
@property (nonatomic, strong) NSString *sAuth;  //作者简介
@property (nonatomic, strong) NSString *sWebLk;  //网页

@end

//
//  TopModel.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

@property (nonatomic, strong) NSString *strHpTitle;  //左上标题
@property (nonatomic, strong) NSString *strOriginalImgUrl; //大图
@property (nonatomic, strong) NSString *strMarketTime;  //发布日期
@property (nonatomic, strong) NSString *strContent;   //文字内容
@property (nonatomic, strong) NSString *strAuthor;   //图片名以及作者
@property (nonatomic, strong) NSString *strPn;     //点赞数
@property (nonatomic, strong) NSString *sWebLk;    //网页

@end

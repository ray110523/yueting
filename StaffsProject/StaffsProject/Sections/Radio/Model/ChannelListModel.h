//
//  ChannelListModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelListModel : NSObject

@property (nonatomic, strong) NSString *addtime_f;  //日期
@property (nonatomic, strong) NSString *coverimg;   //小图
@property (nonatomic, strong) NSString *enname;    //英文标题
@property (nonatomic, strong) NSString *name;     //中文标题
@property (nonatomic, strong) NSString *picurl;    //大图
@property (nonatomic, strong) NSString *type;     //类型

@end

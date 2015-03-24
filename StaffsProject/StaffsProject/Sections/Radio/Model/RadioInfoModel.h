//
//  RadioInfoModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoModel;

@interface RadioInfoModel : NSObject

@property (nonatomic, strong) NSString *coverimg;  //图片
@property (nonatomic, strong) NSString *desc;   //描述
@property (nonatomic, strong) NSString *musicvisitnum;   //访问数量
@property (nonatomic, strong) NSString *radioid;   //电台id
@property (nonatomic, strong) NSString *title;   //电台标题

@property (nonatomic, strong) UserInfoModel *userinfo;

@end

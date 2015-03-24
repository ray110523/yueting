//
//  RadioListModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoModel;

@interface RadioListModel : NSObject

@property (nonatomic, strong) NSString *coverimg;  //图片
@property (nonatomic, assign) BOOL isnew;  //是否为新
@property (nonatomic, strong) NSString *radioid; //电台id
@property (nonatomic, strong) NSString *title;  //电台标题

@property (nonatomic, strong) UserInfoModel *userinfo; //主播信息

@end

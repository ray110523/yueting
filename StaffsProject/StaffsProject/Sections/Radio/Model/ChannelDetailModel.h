//
//  ChannelDetailModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChannelPlayInfoModel, ChannelUserInfoModel;

@interface ChannelDetailModel : NSObject

@property (nonatomic, strong) NSString *addtime_f;
@property (nonatomic, strong) NSString *musicUrl;
@property (nonatomic, strong) NSString *musicVisit;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *tingid;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) ChannelPlayInfoModel *playInfo;
@property (nonatomic, strong) ChannelUserInfoModel *userinfo;
@property (nonatomic, strong) ChannelUserInfoModel *authorinfo;

@end

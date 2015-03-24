//
//  ChannelPlayInfoModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChannelUserInfoModel;

@interface ChannelPlayInfoModel : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *musicUrl;
@property (nonatomic, strong) NSString *ting_contentid;
@property (nonatomic, strong) NSString *tingid;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) ChannelUserInfoModel *userinfo;
@property (nonatomic, strong) ChannelUserInfoModel *authorinfo;

@end

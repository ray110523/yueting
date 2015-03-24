//
//  RadioInfoListModel.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChannelPlayInfoModel;

@interface RadioInfoListModel : NSObject

@property (nonatomic, strong) NSString *coverimg;
@property (nonatomic, assign) BOOL isnew;
@property (nonatomic, strong) NSString *musicUrl;
@property (nonatomic, strong) NSString *musicVisit;
@property (nonatomic, strong) NSString *tingid;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) ChannelPlayInfoModel *playInfo;

@end

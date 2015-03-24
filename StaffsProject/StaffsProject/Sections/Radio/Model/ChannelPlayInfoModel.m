//
//  ChannelPlayInfoModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChannelPlayInfoModel.h"
#import "ChannelUserInfoModel.h"

@implementation ChannelPlayInfoModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        self.userinfo = [[ChannelUserInfoModel alloc] init];
        [self.userinfo setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"authorinfo"]) {
        self.authorinfo = [[ChannelUserInfoModel alloc] init];
        [self.authorinfo setValuesForKeysWithDictionary:value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

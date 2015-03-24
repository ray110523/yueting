//
//  ChannelUserInfoModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChannelUserInfoModel.h"

@implementation ChannelUserInfoModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"uid"]) {
        self.uid = [NSString stringWithFormat:@"%@", value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

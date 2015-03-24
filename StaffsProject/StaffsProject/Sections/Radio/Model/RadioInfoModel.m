//
//  RadioInfoModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioInfoModel.h"
#import "UserInfoModel.h"

@implementation RadioInfoModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"musicvisitnum"]) {
        self.musicvisitnum = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"userinfo"]) {
        self.userinfo = [[UserInfoModel alloc] init];
        [self.userinfo setValuesForKeysWithDictionary:value];
    }
}

@end

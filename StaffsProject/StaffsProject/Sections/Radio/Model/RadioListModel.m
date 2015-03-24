//
//  RadioListModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioListModel.h"
#import "UserInfoModel.h"

@implementation RadioListModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        self.userinfo = [[UserInfoModel alloc] init];
        [self.userinfo setValuesForKeysWithDictionary:value];
    }
}

@end

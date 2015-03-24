//
//  UserInfoModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"uid"]) {
        self.uid = [NSString stringWithFormat:@"%@", value];
    }
}

@end

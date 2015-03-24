//
//  RadioInfoListModel.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioInfoListModel.h"
#import "ChannelPlayInfoModel.h"

@implementation RadioInfoListModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfo = [[ChannelPlayInfoModel alloc] init];
        [self.playInfo setValuesForKeysWithDictionary:value];
    }
}

@end

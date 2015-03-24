//
//  NumToMonth.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-8.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "NumToMonth.h"

@implementation NumToMonth

+ (NSString *)numberToEnglish:(NSString *)month
{
    int m = [month intValue];
    switch (m) {
        case 1:
            return @"Jan.";
        case 2:
            return @"Feb.";
        case 3:
            return @"Mar.";
        case 4:
            return @"Apr.";
        case 5:
            return @"May.";
        case 6:
            return @"Jun.";
        case 7:
            return @"July.";
        case 8:
            return @"Aug.";
        case 9:
            return @"Sept.";
        case 10:
            return @"Oct.";
        case 11:
            return @"Nov.";
        case 12:
            return @"Dec.";
            
            
        default:
            return 0;
    }
}

@end

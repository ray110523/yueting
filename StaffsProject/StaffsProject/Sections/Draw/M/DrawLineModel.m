//
//  DrawLineModel.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "DrawLineModel.h"

@implementation DrawLineModel

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(CGFloat)width array:(NSMutableArray *)mArray
{
    if (self = [super init]) {
        self.red = red;
        self.green = green;
        self.blue = blue;
        self.alpha = alpha;
        self.lineWidth = width;
        self.pointArray = [NSMutableArray arrayWithArray:mArray];
    }
    return self;
}


@end

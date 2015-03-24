//
//  DrawLineModel.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-9.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DrawLineModel : NSObject

@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;
@property (nonatomic) CGFloat alpha;

@property (nonatomic) CGFloat lineWidth;

@property (nonatomic, strong) NSMutableArray *pointArray;

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lineWidth:(CGFloat)width array:(NSMutableArray *)mArray;

@end

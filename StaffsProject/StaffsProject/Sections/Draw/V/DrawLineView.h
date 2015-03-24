//
//  DrawLineView.h
//  DrawRectDemo
//
//  Created by Ray.M on 14-12-31.
//  Copyright (c) 2014年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineView : UIView

//存放点的数组
@property (nonatomic, strong) NSMutableArray *totalArray;
//红
@property (nonatomic) CGFloat red;
//绿
@property (nonatomic) CGFloat green;
//蓝
@property (nonatomic) CGFloat blue;
//透明
@property (nonatomic) CGFloat alpha;
//线宽
@property (nonatomic, assign, readwrite) CGFloat width;
//用来判断是否清空所绘内容
@property (nonatomic, assign) BOOL flag;


//绘制内容
//drawRect的调用:
//如果在初始化时没有设置UIView的rect,这个方法就无法自动调用
//如果设置了rect,会在ViewController的loadView以及viewDidLoad两个方法之后,自动调用这个方法
//如果在其他时刻需要调用此方法,可以调用setNeedsDisplay来触发此方法
- (void)drawInContext:(CGContextRef)context;

@end

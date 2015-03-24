//
//  DrawLineView.m
//  DrawRectDemo
//
//  Created by Ray.M on 14-12-31.
//  Copyright (c) 2014年 Ray.M. All rights reserved.
//

#import "DrawLineView.h"
#import "DrawLineModel.h"


@implementation DrawLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
    DrawLineModel *lineModel = [[DrawLineModel alloc] initWithRed:_red green:_green blue:_blue alpha:_alpha lineWidth:_width array:tempArray];
    
    [_totalArray addObject:lineModel];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSValue *pValue = [NSValue valueWithCGPoint:point];
    [[self.totalArray.lastObject pointArray] addObject:pValue];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSValue *pValue = [NSValue valueWithCGPoint:[touch locationInView:self]];
    [[self.totalArray.lastObject pointArray] addObject:pValue];
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)context
{
    self.backgroundColor = [UIColor whiteColor];
    //清空之前所绘内容
    CGContextClearRect(context, self.bounds);
    if (_flag) {
        [self clearPath:context];
        _flag = NO;
    } else {
        for (DrawLineModel *lineModel in _totalArray) {
            for (int i = 1; i < lineModel.pointArray.count; i++) {
                //设置画笔颜色
                CGContextSetRGBStrokeColor(context, [lineModel red] / 255., [lineModel green] / 255., [lineModel blue] / 255., [lineModel alpha] / 10.);
                //将当前状态推进栈内
                CGContextSaveGState(context);
                //设置起点
                //CGPointValue是NSValue的实例方法,返回一个CGPoint
                CGContextMoveToPoint(context, [lineModel.pointArray[i - 1] CGPointValue].x, [lineModel.pointArray[i - 1] CGPointValue].y);
                //设置终点
                CGContextAddLineToPoint(context, [lineModel.pointArray[i] CGPointValue].x, [lineModel.pointArray[i] CGPointValue].y);
                //设置画笔宽度
                CGContextSetLineWidth(context, lineModel.lineWidth);
                //设置拐角风格
                CGContextSetLineJoin(context, kCGLineJoinRound);
                //显示所绘图形
                CGContextStrokePath(context);
                //将栈顶状态弹出,还原状态
                CGContextRestoreGState(context);
            }
        }
        
    }
}

//- (void)recordPointsWithPan:(UIPanGestureRecognizer *)pan
//{
//    //首先判断pan手势的状态，如果是开始状态，就创建一个可变数组，添加到属性totalArray中，如果不是就将pan手势所在的位置添加到totalArray的最后一个元素中
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
//        [_totalArray addObject:tempArray];
//        [self setNeedsDisplay];
//    } else {
//        //-locationInView:方法可以获得手势所在的屏幕位置
//        CGPoint point = [pan locationInView:pan.view];
//        //由于CGPoint类型的变量并不是对象，所以不能直接存到数组中，需要先转成NSValue类型，再存入数组
//        [[_totalArray lastObject] addObject:[NSValue valueWithCGPoint:point]];
//        [self setNeedsDisplay];
//    }
//}
//清空画面
- (void)clearPath:(CGContextRef)context
{
    [_totalArray removeAllObjects];
    CGContextClearRect(context, self.bounds);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

@end

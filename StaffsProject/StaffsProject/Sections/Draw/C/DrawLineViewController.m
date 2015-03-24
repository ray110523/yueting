//
//  LineViewController.m
//  DrawRectDemo
//
//  Created by Ray.M on 14-12-31.
//  Copyright (c) 2014年 Ray.M. All rights reserved.
//

#import "DrawLineViewController.h"
#import "DrawLineView.h"
#import "ChangeColorView.h"
#import "MoreView.h"
#import "ADCircularMenuViewController.h"
#import "Frames.h"

@interface DrawLineViewController () <ADCircularMenuDelegate>

@property (nonatomic, strong) ChangeColorView *lineColorView;
@property (nonatomic, strong) MoreView *moreView;

@end

@implementation DrawLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //控制线宽的UISlider
    UISlider *wSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 20 * 2 - 40 * 2, 30)];
    wSlider.minimumValue = 0.5;
    wSlider.maximumValue = 10;
    [wSlider addTarget:self action:@selector(changeWidth:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:wSlider];
    self.navigationItem.titleView = wSlider;

    UIBarButtonItem *backColorItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(doMore)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"画笔色" style:UIBarButtonItemStylePlain target:self action:@selector(changeLineColor)];
    self.navigationItem.rightBarButtonItem = backColorItem;
    
    
    //初始化实例变量lineView
    self.lineView = [[DrawLineView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - STATUSBARHEIGHT - NAVBARHEIGHT - TABBARHEIGHT)];
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.lineView.totalArray = [NSMutableArray array];
    self.lineView.userInteractionEnabled = YES;
    self.lineView.red = 255;
    self.lineView.green = 255;
    self.lineView.blue = 255;
    self.lineView.alpha = 10;
    self.lineView.width = 0.5;
    [self.view addSubview:self.lineView];
    
    self.lineColorView = [[ChangeColorView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + NAVBARHEIGHT, 300, 320)];
    self.lineColorView.backgroundColor = [UIColor whiteColor];
    [self.lineColorView.cancleBtn addTarget:self action:@selector(cancleClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.lineColorView.sureBtn addTarget:self action:@selector(sureClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lineColorView];
    self.lineColorView.hidden = YES;
    
    self.moreView = [[[UINib nibWithNibName:@"MoreView" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    self.moreView.frame = CGRectMake(SCREENWIDTH - 100, STATUSBARHEIGHT + NAVBARHEIGHT, 100, 180);
    self.moreView.backgroundColor = [UIColor whiteColor];
    [self.moreView.clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView.saveBtn addTarget:self action:@selector(saveDraw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_moreView];
    self.moreView.hidden = YES;
    
    
    
//    //清除按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(0, SCREENHEIGHT - TABBARHEIGHT - 40, 40, 30);
//    button.layer.borderWidth = 0.5;
//    [button setTitle:@"清除" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    //撤销按钮
//    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    buttonBack.frame = CGRectMake(SCREENWIDTH - 40, SCREENHEIGHT - TABBARHEIGHT - 40, 40, 30);
//    buttonBack.layer.borderWidth = 0.5;
//    [buttonBack setTitle:@"撤销" forState:UIControlStateNormal];
//    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:buttonBack];
    
}

- (void)changeLineColor
{
    if (self.lineColorView.hidden) {
        self.lineColorView.labelRed.text = [NSString stringWithFormat:@"%d", (int)self.lineView.red];
        self.lineColorView.sliderRed.value = self.lineView.red;
        
        self.lineColorView.labelGreen.text = [NSString stringWithFormat:@"%d", (int)self.lineView.green];
        self.lineColorView.sliderGreen.value = self.lineView.green;
        
        self.lineColorView.labelBlue.text = [NSString stringWithFormat:@"%d", (int)self.lineView.blue];
        self.lineColorView.sliderBlue.value = self.lineView.blue;
        
        self.lineColorView.labelAlpha.text = [NSString stringWithFormat:@"%d", (int)self.lineView.alpha];
        self.lineColorView.sliderAlpha.value = self.lineView.alpha;
        
        [self.lineColorView setHidden:NO];
    } else {
        [self.lineColorView setHidden:YES];
    }
    if (!self.moreView.hidden) {
        self.moreView.hidden = YES;
    }
    
    
}

- (void)doMore
{
    if (self.moreView.hidden) {
        self.moreView.hidden = NO;
    } else {
        self.moreView.hidden = YES;
    }
    if (!self.lineColorView.hidden) {
        self.lineColorView.hidden = YES;
    }
}

//获取view上的图形内容
-(UIImage *)getImageFromView:(UIView *)orgView{
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//- (void)pan:(UIPanGestureRecognizer *)pan
//{
//    [self.lineView recordPointsWithPan:pan];
//}

#pragma mark - SliderTargets

- (void)changeWidth:(UISlider *)aSlider
{
    self.lineView.width = aSlider.value;
}

#pragma mark - ButtonTargets

- (void)clear
{
    self.moreView.hidden = YES;
    self.lineView.flag = YES;
    [self.lineView setNeedsDisplay];
}

- (void)back
{
    [self.lineView.totalArray removeLastObject];
    [self.lineView setNeedsDisplay];
}

- (void)saveDraw
{
    self.moreView.hidden = YES;
    UIImage *image = [self getImageFromView:self.lineView];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存成功" message:@"绘图已保存至相册中" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)cancleClicked
{
    self.lineColorView.hidden = YES;
}

- (void)sureClicked
{
    self.lineView.red = self.lineColorView.sliderRed.value;
    self.lineView.green = self.lineColorView.sliderGreen.value;
    self.lineView.blue = self.lineColorView.sliderBlue.value;
    self.lineView.alpha = self.lineColorView.sliderAlpha.value;
    self.lineColorView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - ADCircularMenuDelegate
//
//- (void)circularMenuClickedButtonAtIndex:(int)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//            self.lineView.red = 10;
//            self.lineView.green = 10;
//            self.lineView.blue = 255;
//            break;
//        case 1:
//            self.lineView.red = 255;
//            self.lineView.green = 10;
//            self.lineView.blue = 10;
//            break;
//        case 2:
//            self.lineView.red = 10;
//            self.lineView.green = 255;
//            self.lineView.blue = 10;
//            break;
//        case 3:
//            self.lineView.red = 255;
//            self.lineView.green = 100;
//            self.lineView.blue = 200;
//            break;
//        case 4:
//            self.lineView.red = 175;
//            self.lineView.green = 250;
//            self.lineView.blue = 10;
//            break;
//        case 5:
//            self.lineView.red = 50;
//            self.lineView.green = 169;
//            self.lineView.blue = 136;
//            break;
//        case 6:
//            self.lineView.red = 175;
//            self.lineView.green = 175;
//            self.lineView.blue = 175;
//            break;
//        case 7:
//            self.lineView.red = 90;
//            self.lineView.green = 90;
//            self.lineView.blue = 90;
//            break;
//        case 8:
//            self.lineView.red = 90;
//            self.lineView.green = 188;
//            self.lineView.blue = 255;
//            break;
//        case 9:
//            self.lineView.red = 134;
//            self.lineView.green = 250;
//            self.lineView.blue = 98;
//            break;
//        case 10:
//            self.lineView.red = 64;
//            self.lineView.green = 164;
//            self.lineView.blue = 80;
//            break;
//        case 11:
//            self.lineView.red = 150;
//            self.lineView.green = 10;
//            self.lineView.blue = 10;
//            break;
//            
//            
//            
//        default:
//            break;
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

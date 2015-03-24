//
//  ChangeColorView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-10.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChangeColorView.h"
#import "Frames.h"

@interface ChangeColorView ()

@end

@implementation ChangeColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cancleBtn.frame = CGRectMake(MARGIN, MARGIN, 50, 50);
        [self.cancleBtn setImage:[UIImage imageNamed:@"cancle-"] forState:UIControlStateNormal];
        [self addSubview:_cancleBtn];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.sureBtn.frame = CGRectMake(240, MARGIN, 50, 50);
        [self.sureBtn setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        [self addSubview:_sureBtn];
        
        self.colorView = [[UIView alloc] initWithFrame:CGRectMake(130, 50, 40, 40)];
        self.backgroundColor = [UIColor whiteColor];
        self.colorView.layer.borderColor = [UIColor blackColor].CGColor;
        self.colorView.layer.borderWidth = 0.5;
        self.colorView.layer.cornerRadius = 20;
        self.colorView.clipsToBounds = YES;
        [self addSubview:_colorView];
        
        //红色
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, 120, 30, 30)];
        redView.backgroundColor = [UIColor redColor];
        redView.layer.cornerRadius = 15;
        redView.clipsToBounds = YES;
        [self addSubview:redView];
        self.sliderRed = [[UISlider alloc] initWithFrame:CGRectMake(50, 120, 200, 30)];
        self.sliderRed.minimumValue = 0.0;
        self.sliderRed.maximumValue = 255.0;
        [self.sliderRed addTarget:self action:@selector(changeRed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.sliderRed];
        self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(250, 120, 40, 30)];
        self.labelRed.font = [UIFont systemFontOfSize:12];
        [self addSubview:_labelRed];
        
        //绿色
        UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, 170, 30, 30)];
        greenView.backgroundColor = [UIColor greenColor];
        greenView.layer.cornerRadius = 15;
        greenView.clipsToBounds = YES;
        [self addSubview:greenView];
        self.sliderGreen = [[UISlider alloc] initWithFrame:CGRectMake(50, 170, 200, 30)];
        self.sliderGreen.minimumValue = 0.0;
        self.sliderGreen.maximumValue = 255.0;
        [self.sliderGreen addTarget:self action:@selector(changeRed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.sliderGreen];
        self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(250, 170, 40, 30)];
        self.labelGreen.font = [UIFont systemFontOfSize:12];
        [self addSubview:_labelGreen];
        
        //蓝色
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, 220, 30, 30)];
        blueView.backgroundColor = [UIColor blueColor];
        blueView.layer.cornerRadius = 15;
        blueView.clipsToBounds = YES;
        [self addSubview:blueView];
        self.sliderBlue = [[UISlider alloc] initWithFrame:CGRectMake(50, 220, 200, 30)];
        self.sliderBlue.minimumValue = 0.0;
        self.sliderBlue.maximumValue = 255.0;
        [self.sliderBlue addTarget:self action:@selector(changeRed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.sliderBlue];
        self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(250, 220, 40, 30)];
        self.labelBlue.font = [UIFont systemFontOfSize:12];
        [self addSubview:_labelBlue];
        
        //透明度
        UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, 270, 30, 30)];
        alphaView.backgroundColor = [UIColor colorWithRed:175 / 255. green:175 / 255. blue:175 / 255. alpha:1];
        alphaView.layer.cornerRadius = 15;
        alphaView.clipsToBounds = YES;
        [self addSubview:alphaView];
        self.sliderAlpha = [[UISlider alloc] initWithFrame:CGRectMake(50, 270, 200, 30)];
        self.sliderAlpha.minimumValue = 0;
        self.sliderAlpha.maximumValue = 10;
        [self.sliderAlpha addTarget:self action:@selector(changeAlpha:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_sliderAlpha];
        self.labelAlpha = [[UILabel alloc] initWithFrame:CGRectMake(250, 270, 40, 30)];
        self.labelAlpha.font = [UIFont systemFontOfSize:12];
        [self addSubview:_labelAlpha];
        
        self.labelRed.text = [NSString stringWithFormat:@"%d", 255];
        self.labelGreen.text = [NSString stringWithFormat:@"%d", 255];
        self.labelBlue.text = [NSString stringWithFormat:@"%d", 255];
        self.labelAlpha.text = [NSString stringWithFormat:@"%d", 10];
        [self.sliderRed addTarget:self action:@selector(changeRed:) forControlEvents:UIControlEventValueChanged];
        [self.sliderGreen addTarget:self action:@selector(changeGreen:) forControlEvents:UIControlEventValueChanged];
        [self.sliderBlue addTarget:self action:@selector(changeBlue:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


- (void)changeRed:(UISlider *)slider
{
    int r = _sliderRed.value;
    self.labelRed.text = [NSString stringWithFormat:@"%d", r];
    self.colorView.backgroundColor = [UIColor colorWithRed:self.sliderRed.value / 255. green:self.sliderGreen.value / 255. blue:self.sliderBlue.value / 255. alpha:self.sliderAlpha.value / 10.];
}

- (void)changeGreen:(UISlider *)slider
{
    int g = _sliderGreen.value;
    self.labelGreen.text = [NSString stringWithFormat:@"%d", g];
    self.colorView.backgroundColor = [UIColor colorWithRed:self.sliderRed.value / 255. green:self.sliderGreen.value / 255. blue:self.sliderBlue.value / 255. alpha:self.sliderAlpha.value / 10.];
}
- (void)changeBlue:(UISlider *)slider
{
    int b = _sliderBlue.value;
    self.labelBlue.text = [NSString stringWithFormat:@"%d", b];
    self.colorView.backgroundColor = [UIColor colorWithRed:self.sliderRed.value / 255. green:self.sliderGreen.value / 255. blue:self.sliderBlue.value / 255. alpha:self.sliderAlpha.value / 10.];
}
- (void)changeAlpha:(UISlider *)slider {
    int a = _sliderAlpha.value;
    self.labelAlpha.text = [NSString stringWithFormat:@"%d", a];
    self.colorView.backgroundColor = [UIColor colorWithRed:self.sliderRed.value / 255. green:self.sliderGreen.value / 255. blue:self.sliderBlue.value / 255. alpha:self.sliderAlpha.value / 10.];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

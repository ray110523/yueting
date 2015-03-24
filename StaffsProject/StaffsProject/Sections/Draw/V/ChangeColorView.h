//
//  ChangeColorView.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-10.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeColorView : UIView

@property (strong, nonatomic)  UISlider *sliderRed;
@property (strong, nonatomic)  UISlider *sliderGreen;
@property (strong, nonatomic)  UISlider *sliderBlue;
@property (strong, nonatomic)  UISlider *sliderAlpha;

@property (strong, nonatomic)  UILabel *labelRed;
@property (strong, nonatomic)  UILabel *labelGreen;
@property (strong, nonatomic)  UILabel *labelBlue;
@property (strong, nonatomic)  UILabel *labelAlpha;

@property (strong, nonatomic)  UIView *colorView;

@property (strong, nonatomic)  UIButton *sureBtn;
@property (strong, nonatomic)  UIButton *cancleBtn;


@end

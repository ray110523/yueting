//
//  RadioPlayViewController.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioListModel;

@interface RadioPlayViewController : UIViewController

@property (nonatomic, strong) RadioListModel *model;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) int index;

@end

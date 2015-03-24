//
//  RadioViewController.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoMoreView;

@interface RadioViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *selectDataArray;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NoMoreView *nomoreView;

@property (nonatomic, assign) int start;
@property (nonatomic, assign) int total;

@end

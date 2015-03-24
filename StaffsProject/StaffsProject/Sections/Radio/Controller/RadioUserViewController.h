//
//  RadioUserViewController.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioInfoModel;

@interface RadioUserViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RadioInfoModel *radioInfo;
@property (nonatomic, strong) NSMutableArray *listDataArray;

@property (nonatomic, strong) NSString *radioId;
@property (nonatomic, assign) int start;
@property (nonatomic, assign) int total;

@end

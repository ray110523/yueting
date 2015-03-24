//
//  RadioUserTVCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioInfoModel;

@interface RadioUserTVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *picView;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *listenNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *signLabel;

@property (nonatomic, strong) RadioInfoModel *model;

@end

//
//  RadioUserTVListCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioInfoListModel;

@interface RadioUserTVListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *listenNumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *playImageView;

@property (nonatomic, strong) RadioInfoListModel *model;

@end

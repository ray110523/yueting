//
//  ChannelTVCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChannelListModel;

@interface ChannelTVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *halfImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) ChannelListModel *model;

@end

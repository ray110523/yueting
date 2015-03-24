//
//  ChannelDetailTVCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChannelDetailModel;

@interface ChannelDetailTVCell : UITableViewCell

@property (strong, nonatomic) ChannelDetailModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *picView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

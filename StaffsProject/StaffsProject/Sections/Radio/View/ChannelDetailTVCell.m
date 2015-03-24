//
//  ChannelDetailTVCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChannelDetailTVCell.h"
#import "ChannelDetailModel.h"
#import "ChannelUserInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation ChannelDetailTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ChannelDetailModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.picView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:nil];
    self.titleLabel.text = _model.title;
    self.nameLabel.text = _model.userinfo.uname;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  RadioUserTVListCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioUserTVListCell.h"
#import "RadioInfoListModel.h"
#import "ChannelPlayInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation RadioUserTVListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(RadioInfoListModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_model.coverimg] placeholderImage:[UIImage imageNamed:@"avatar-placeholder"]];
    self.titleLabel.text = _model.playInfo.title;
    self.listenNumLabel.text = _model.musicVisit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

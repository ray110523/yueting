//
//  ChannelTVCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChannelTVCell.h"
#import "ChannelListModel.h"
#import "UIImageView+WebCache.h"

@implementation ChannelTVCell

- (void)awakeFromNib {
    // Initialization code
    self.model = [[ChannelListModel alloc] init];
}

- (void)setModel:(ChannelListModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.picurl] placeholderImage:nil];
    [self.halfImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverimg] placeholderImage:nil];
    self.dateLabel.text = _model.addtime_f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

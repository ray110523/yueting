//
//  RadioUserTVCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioUserTVCell.h"
#import "RadioInfoModel.h"
#import "UserInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation RadioUserTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(RadioInfoModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.picView sd_setImageWithURL:[NSURL URLWithString:_model.coverimg] placeholderImage:[UIImage imageNamed:@"BoardcastListCellMask"]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_model.userinfo.icon] placeholderImage:[UIImage imageNamed:@"avatar-placeholder"]];
    self.userNameLabel.text = _model.title;
#warning --------
    self.listenNumLabel.text = _model.musicvisitnum;
    self.signLabel.text = _model.desc;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

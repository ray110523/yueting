//
//  RadioCVCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioCVCell.h"
#import "RadioListModel.h"
#import "UserInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation RadioCVCell

- (void)awakeFromNib {
    // Initialization code
    self.model = [[RadioListModel alloc] init];
}

- (void)setModel:(RadioListModel *)model
{
    if (model != _model) {
        _model = model;
    }
    if (model.isnew) {
        self.isNewView.image = [UIImage imageNamed:@"Boardcast_New"];
    }
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.nameLabel.text = [NSString stringWithFormat:@"by:%@", model.userinfo.uname];
}

@end

//
//  RadioCVCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioListModel;

@interface RadioCVCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *isNewView;
@property (strong, nonatomic) IBOutlet UIImageView *picView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) RadioListModel *model;

@end

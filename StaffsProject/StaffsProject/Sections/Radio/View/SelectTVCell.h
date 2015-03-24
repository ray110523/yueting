//
//  SelectTVCell.h
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioListCollectionView, RadioUserViewController;

typedef void (^blockPush)(RadioUserViewController *radioUserVC);

@interface SelectTVCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, copy) blockPush pushVC;

- (void)setBlock:(blockPush)block;

@end

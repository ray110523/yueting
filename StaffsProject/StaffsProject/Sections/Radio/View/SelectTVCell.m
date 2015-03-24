//
//  SelectTVCell.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "SelectTVCell.h"
#import "RadioCVCell.h"
#import "RadioListModel.h"
#import "RadioUserViewController.h"
#import "Frames.h"

@interface SelectTVCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SelectTVCell

- (void)awakeFromNib {
    // Initialization code
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((SCREENWIDTH - MARGIN * 4) / 3, (SCREENWIDTH - MARGIN * 4) / 3 + LABELHEIGHT);
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RadioCVCell" bundle:nil] forCellWithReuseIdentifier:@"radioCVCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
    [self.collectionView reloadData];
}

- (void)setBlock:(blockPush)block
{
    self.pushVC = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"radioCVCell" forIndexPath:indexPath];
        cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioUserViewController *radioUserVC = [[RadioUserViewController alloc] init];
    radioUserVC.radioId = [_dataArray[indexPath.row] radioid];
    self.pushVC(radioUserVC);
}

@end

//
//  RadioListCollectionView.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioListCollectionView.h"
#import "RadioCVCell.h"
#import "Frames.h"

@interface RadioListCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation RadioListCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        self.dataArray = [NSMutableArray array];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREENWIDTH - MARGIN * 4) / 3, (SCREENWIDTH - MARGIN * 4) / 3 + LABELHEIGHT);
        self.collectionViewLayout = flowLayout;
        
        [self registerNib:[UINib nibWithNibName:@"RadioCVCell" bundle:nil] forCellWithReuseIdentifier:@"radioCVCell"];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
//    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"radioCVCell" forIndexPath:indexPath];
//    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

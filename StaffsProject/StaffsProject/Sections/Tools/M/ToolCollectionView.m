//
//  ToolCollectionView.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-6.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ToolCollectionView.h"
#import "ToolCollectionCell.h"
#import "Frames.h"

@interface ToolCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ToolCollectionView

- (void)setCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 0.1;
    flowLayout.minimumLineSpacing = 0.1;
    flowLayout.itemSize = CGSizeMake(SCREENWIDTH / 3 - 1, SCREENWIDTH / 3 - 1);
    flowLayout.sectionInset = UIEdgeInsetsMake(0.5, 0.7, 0, 0);
    
    self.collectionViewLayout = flowLayout;
    self.backgroundColor = [UIColor whiteColor];
    
    [self registerNib:[UINib nibWithNibName:@"ToolCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"toolCell"];
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ToolCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"toolCell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell.imageV setImage:[UIImage imageNamed:@"bg_tool_hero"]];
    cell.titleL.text = @"英雄";
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

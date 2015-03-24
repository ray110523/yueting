//
//  RadioViewController.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//  http://api2.pianke.me/pub/screen   启动画面
//  http://api2.pianke.me/pub/today  start=0&client=2&limit=10  精选
//  

#import "RadioViewController.h"
#import "ChannelViewController.h"
#import "RadioUserViewController.h"
#import "RadioListCollectionView.h"
#import "PlayViewController.h"
#import "NoMoreView.h"
#import "SelectTVCell.h"
#import "RadioListModel.h"
#import "DataParse.h"
#import "Frames.h"
#import "MJRefresh.h"

@interface RadioViewController ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"频道" style:UIBarButtonItemStylePlain target:self action:@selector(clickToChannel)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_home_player"] style:UIBarButtonItemStylePlain target:self action:@selector(radioPlaying)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectTVCell" bundle:nil] forCellReuseIdentifier:@"selectTVCell"];
    self.selectDataArray = [NSMutableArray array];
    self.allDataArray = [NSMutableArray array];
    self.start = 0;
    self.total = 0;
    [self getData];
    
    __weak RadioViewController *blockSelf = self;
    
    [self.tableView addHeaderWithCallback:^{
        blockSelf.start = 0;
        blockSelf.selectDataArray = [NSMutableArray array];
        blockSelf.allDataArray = [NSMutableArray array];
        [blockSelf getData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        if ((blockSelf.total != 0 && blockSelf.start < blockSelf.total) || blockSelf.total == 0) {
            blockSelf.start += 9;
            [blockSelf getData];
        } else {
            
            blockSelf.nomoreView.hidden = NO;
            [UIView animateWithDuration:1 animations:^{
                CGRect frame = blockSelf.nomoreView.frame;
                blockSelf.nomoreView.frame = CGRectMake(frame.origin.x, -SCREENHEIGHT / 3, frame.size.width, frame.size.height);
            }];
            blockSelf.nomoreView.hidden = YES;
            blockSelf.nomoreView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        }
    }];
    
    self.nomoreView = [[NoMoreView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.nomoreView.hidden = YES;
    [self.view addSubview:_nomoreView];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BarButtonItem

- (void)clickToChannel
{
    ChannelViewController *channelVC = [[ChannelViewController alloc] init];
    [self.navigationController pushViewController:channelVC animated:YES];
}


- (void)radioPlaying
{
    PlayViewController *playVC = [PlayViewController defaultPlayVC];
    if (playVC.dataArray.count) {
        [self.navigationController pushViewController:playVC animated:YES];
    }
    
}


#pragma mark - DataParse

- (void)getData
{
    DataParse *dataParse = [[DataParse alloc] init];
    __weak RadioViewController *blockSelf = self;
    if (_start != 0) {
        [dataParse setBlock:^(id object) {
            for (NSDictionary *dic in [[object valueForKey:@"data"] objectForKey:@"list"]) {
                RadioListModel *model = [[RadioListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [blockSelf.allDataArray addObject:model];
            }
            blockSelf.total = [[object valueForKey:@"total"] intValue];
            [blockSelf.tableView footerEndRefreshing];
            [blockSelf.tableView reloadData];
        }];
        NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api2.pianke.me/ting/radio_list"]];
        mRequest.HTTPMethod = @"POST";
        mRequest.HTTPBody = [[NSString stringWithFormat:@"start=%d&client=2&limit=9", _start] dataUsingEncoding:NSUTF8StringEncoding];
        [dataParse parseDataWithRequest:mRequest];
    } else {
        [dataParse setBlock:^(id object) {
            for (NSDictionary *dic in [[object valueForKey:@"data"] objectForKey:@"hotlist"]) {
                RadioListModel *model = [[RadioListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [blockSelf.selectDataArray addObject:model];
            }
            for (NSDictionary *dic in [[object valueForKey:@"data"] objectForKey:@"alllist"]) {
                RadioListModel *model = [[RadioListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [blockSelf.allDataArray addObject:model];
            }
            [blockSelf.tableView headerEndRefreshing];
            [blockSelf.tableView reloadData];
            
        }];
        [dataParse parseDataWithAPI:@"http://api2.pianke.me/ting/radio?client=2"];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SelectTVCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"selectTVCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"精选电台·Fetures Radios";
        cell.dataArray = self.selectDataArray;
    } else {
        cell.titleLabel.text = @"全部电台·All Stations";
        cell.dataArray = self.allDataArray;
    }
    __weak RadioViewController *blockSelf = self;
    [cell setBlock:^(RadioUserViewController *radioUserVC) {
        [blockSelf.navigationController pushViewController:radioUserVC animated:YES];
    }];
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row) {
        return MARGIN * 4 + ((SCREENWIDTH - MARGIN * 4) / 3 + 31) * (self.allDataArray.count / 3);
    } else {
        return MARGIN * 5 + (SCREENWIDTH - MARGIN * 4) / 3 + 31;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ChannelDetailViewController.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-13.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "ChannelDetailViewController.h"
#import "PlayViewController.h"
#import "ChannelDetailTVCell.h"
#import "ChannelDetailModel.h"
#import "DataParse.h"
#import "MJRefresh.h"
#import "Frames.h"
#import "AudioStreamer.h"

@interface ChannelDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChannelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_home_player"] style:UIBarButtonItemStylePlain target:self action:@selector(radioPlaying)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.dataArray = [NSMutableArray array];
    self.total = 0;
    self.start = 0;
    [self getData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChannelDetailTVCell" bundle:nil] forCellReuseIdentifier:@"channelDetailTVCell"];
    
    __weak ChannelDetailViewController *blockSelf = self;
    [self.tableView addHeaderWithCallback:^{
        blockSelf.start = 0;
        blockSelf.dataArray = [NSMutableArray array];
        [blockSelf getData];
        [blockSelf.tableView reloadData];
        [blockSelf.tableView headerEndRefreshing];
    }];
    
    [self.tableView addFooterWithCallback:^{
        blockSelf.start += 10;
        [blockSelf getData];
        [blockSelf.tableView footerEndRefreshing];
    }];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)radioPlaying
{
    PlayViewController *playVC = [PlayViewController defaultPlayVC];
    if (playVC.dataArray.count) {
        [self.navigationController pushViewController:playVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataParse

- (void)getData
{
    DataParse *dataParse = [[DataParse alloc] init];
    __weak ChannelDetailViewController *blockSelf = self;
    [dataParse setBlock:^(id object) {
        blockSelf.total = [[[object valueForKey:@"data"] valueForKey:@"total"] intValue];
        for (NSDictionary *dic in [[object valueForKey:@"data"] valueForKey:@"list"]) {
            ChannelDetailModel *model = [[ChannelDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [blockSelf.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.pianke.me/ting/category_detail"]];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [[NSString stringWithFormat:@"client=1&limit=10&sort=addtime&start=%d&type=%@", self.start, self.type] dataUsingEncoding:NSUTF8StringEncoding];
    [dataParse parseDataWithRequest:mRequest];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelDetailTVCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENWIDTH / 16 * 9;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PlayViewController *playVC = [[[UINib nibWithNibName:@"PlayViewController" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    PlayViewController *playVC = [PlayViewController defaultPlayVC];
    playVC.pause = YES;
    [playVC.playBtn setBackgroundImage:[UIImage imageNamed:@"TingPlayerPlay"] forState:UIControlStateNormal];
    playVC.dataArray = _dataArray;
    playVC.model = _dataArray[indexPath.row];
    playVC.index = indexPath.row;
    [playVC.timerCount invalidate];
    [playVC.audioStreamer stop];
    [playVC destroyStreamer];
    [playVC refreshLayout];
    
    [self.navigationController pushViewController:playVC animated:YES];
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

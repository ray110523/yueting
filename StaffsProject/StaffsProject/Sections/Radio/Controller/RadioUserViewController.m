//
//  RadioUserViewController.m
//  StaffsProject
//
//  Created by Ray.M on 15-3-14.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "RadioUserViewController.h"
#import "PlayViewController.h"
#import "RadioUserTVCell.h"
#import "RadioUserTVListCell.h"
#import "RadioInfoModel.h"
#import "RadioInfoListModel.h"
#import "ChannelDetailModel.h"
#import "ChannelUserInfoModel.h"
#import "UserInfoModel.h"
#import "DataParse.h"
#import "MJRefresh.h"
#import "Frames.h"
#import "AudioStreamer.h"

@interface RadioUserViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RadioUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_home_player"] style:UIBarButtonItemStylePlain target:self action:@selector(radioPlaying)];
    
    self.radioInfo = [[RadioInfoModel alloc] init];
    self.listDataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioUserTVCell" bundle:nil] forCellReuseIdentifier:@"radioUserTVCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioUserTVListCell" bundle:nil] forCellReuseIdentifier:@"radioUserTVListCell"];
    
    self.start = 0;
    self.total = 0;
    [self getData];
    
    __weak RadioUserViewController *blockSelf = self;
    [self.tableView addHeaderWithCallback:^{
        blockSelf.listDataArray = [NSMutableArray array];
        blockSelf.start = 0;
        [blockSelf getData];
        [blockSelf.tableView reloadData];
        [blockSelf.tableView headerEndRefreshing];
    }];
    
    [self.tableView addFooterWithCallback:^{
        if (blockSelf.start < blockSelf.total) {
            blockSelf.start += 10;
            [blockSelf getData];
            [blockSelf.tableView footerEndRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - DataParse

- (void)getData
{
    DataParse *dataParse = [[DataParse alloc] init];
    __weak RadioUserViewController *blockSelf = self;
    [dataParse setBlock:^(id object) {
        [blockSelf.radioInfo setValuesForKeysWithDictionary:[[object objectForKey:@"data"] objectForKey:@"radioInfo"]];
        blockSelf.total = [[[object valueForKey:@"data"] valueForKey:@"total"] intValue];
        for (NSDictionary *dic in [[object objectForKey:@"data"] objectForKey:@"list"]) {
            RadioInfoListModel *model = [[RadioInfoListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [blockSelf.listDataArray addObject:model];
        }
        [blockSelf.tableView reloadData];
    }];
    NSString *url = @"http://api2.pianke.me/ting/radio_detail";
    if (self.start) {
        url = [url stringByAppendingString:@"_list"];
    }
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [[NSString stringWithFormat:@"radioid=%@&start=%d&client=2&limit=10", self.radioId, self.start] dataUsingEncoding:NSUTF8StringEncoding];
    [dataParse parseDataWithRequest:mRequest];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RadioUserTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioUserTVCell" forIndexPath:indexPath];
        cell.model = _radioInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        RadioUserTVListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioUserTVListCell" forIndexPath:indexPath];
        cell.model = _listDataArray[indexPath.row - 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row) {
        return 70;
    } else {
        return 260;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *playVC = [PlayViewController defaultPlayVC];
    playVC.pause = YES;
    [playVC.playBtn setBackgroundImage:[UIImage imageNamed:@"TingPlayerPlay"] forState:UIControlStateNormal];
    playVC.index = indexPath.row - 1;
    playVC.dataArray = [NSMutableArray array];
    for (RadioInfoListModel *model in _listDataArray) {
        ChannelDetailModel *cModel = [[ChannelDetailModel alloc] init];
        cModel.musicUrl = model.musicUrl;
        cModel.musicVisit = model.musicVisit;
        cModel.pic = model.coverimg;
        cModel.tingid = model.tingid;
        cModel.title = model.title;
        cModel.playInfo = model.playInfo;
        cModel.userinfo = [[ChannelUserInfoModel alloc] init];
        cModel.userinfo.icon = _radioInfo.userinfo.icon;
        cModel.userinfo.uname = _radioInfo.userinfo.uname;
        cModel.userinfo.uid = _radioInfo.userinfo.uid;
        [playVC.dataArray addObject:cModel];
    }
    playVC.model = playVC.dataArray[playVC.index];
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

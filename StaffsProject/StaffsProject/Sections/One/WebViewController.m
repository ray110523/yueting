//
//  WebViewController.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-12.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "WebViewController.h"
#import "UIWebView+AFNetworking.h"
#import "Frames.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + TABBARHEIGHT)];
    [self.view addSubview:_webView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    self.tabBarController.tabBar.hidden = YES;
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]] progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        
//    } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
//        return HTML;
//    } failure:^(NSError *error) {
//        NSLog(@"error");
//    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  TabBarViewController.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-5.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "TabBarViewController.h"
#import "RadioViewController.h"
#import "OneViewController.h"
#import "DrawLineViewController.h"
#import "PlayViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.radioRootVC = [[RadioViewController alloc] init];
    UINavigationController *navRadioC = [[UINavigationController alloc] initWithRootViewController:self.radioRootVC];
    navRadioC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电台" image:[UIImage imageNamed:@"tingTabbar"] selectedImage:[UIImage imageNamed:@"tingTabbar_selected"]];
    
    
//    DrawLineViewController *drawVC = [[DrawLineViewController alloc] init];
//    UINavigationController *navDrawC = [[UINavigationController alloc] initWithRootViewController:drawVC];
//    navDrawC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"涂鸦" image:[UIImage imageNamed:@"icon_nav_news"] selectedImage:[UIImage imageNamed:@"icon_nav_news_selected"]];
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    UINavigationController *navOneC = [[UINavigationController alloc] initWithRootViewController:oneVC];
    navOneC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"悦读" image:[UIImage imageNamed:@"todayTabbar"] selectedImage:[UIImage imageNamed:@"todayTabbar_selected@2x"]];
    
    self.viewControllers = @[navRadioC, navOneC];
    
    
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

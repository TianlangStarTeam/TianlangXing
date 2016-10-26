//
//  RootVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootVC.h"
#import "HomePageVC.h"
#import "TLStarVC.h"
#import "ShoppingCartVC.h"
#import "MineVC.h"

@interface RootVC ()<UITabBarDelegate>

@end

@implementation RootVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTabBarController];// 给TabBarController添加4个子控制器
}



#pragma mark - 给TabBarController添加4个子控制器

- (void)setTabBarController
{
    // 首页
    HomePageVC *homeVC = [[HomePageVC alloc] init];
    UINavigationController *homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [homeNC.tabBarItem setImage:[UIImage imageNamed:@"homePage_normal"]];
    [homeNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"homePage_selected"]];
    [homeNC.tabBarItem setTitle:@"首页"];
    homeVC.title = @"首页";
    
    

    // 天狼星
    TLStarVC *tlStarVC = [[TLStarVC alloc] init];
    UINavigationController *tlStarNC = [[UINavigationController alloc] initWithRootViewController:tlStarVC];
    [tlStarNC.tabBarItem setImage:[UIImage imageNamed:@"shengli_normal"]];
    [tlStarNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"shengli_selected"]];
    [tlStarNC.tabBarItem setTitle:@"天狼星"];
    tlStarVC.title = @"天狼星";
    
    
    
    // 购物车
    ShoppingCartVC *shoppingCartVC = [[ShoppingCartVC alloc] init];
    UINavigationController *shoppingCartNC = [[UINavigationController alloc] initWithRootViewController:shoppingCartVC];
    [shoppingCartNC.tabBarItem setImage:[UIImage imageNamed:@"supplier_normal"]];
    [shoppingCartNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"supplier_selected"]];
    [shoppingCartNC.tabBarItem setTitle:@"购物车"];
    shoppingCartVC.title = @"购物车";
    
    
    
    // 首页
    MineVC *mineVC = [[MineVC alloc] init];
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [mineNC.tabBarItem setImage:[UIImage imageNamed:@"homePage_normal"]];
    [mineNC.tabBarItem setSelectedImage:[UIImage imageNamed:@"homePage_selected"]];
    [mineNC.tabBarItem setTitle:@"我的"];
    mineVC.title = @"我的";
    
    
    
    self.viewControllers = @[homeNC,tlStarNC,shoppingCartNC,mineNC];
    self.tabBar.tintColor = [UIColor colorWithRed:0.993 green:0.673 blue:0.156 alpha:1.000];
    
    homeVC.view.backgroundColor = [UIColor orangeColor];
    tlStarVC.view.backgroundColor = [UIColor orangeColor];
    shoppingCartVC.view.backgroundColor = [UIColor orangeColor];
    mineVC.view.backgroundColor = [UIColor orangeColor];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

//
//  HomePageVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageVC.h"

#import "TestInterfaceVC.h"

@interface HomePageVC ()<UISearchBarDelegate,UISearchResultsUpdating>

// 搜索框
@property (nonatomic,strong) UISearchController *search;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchController];// 添加搜索框
    
    [self shareItem];// 分享app
    
    
    
    // 测试接口按钮
    UIButton *testButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    testButton.frame = CGRectMake(50, 100, 100, 44);
    [testButton setTitle:@"测试接口" forState:(UIControlStateNormal)];
    [testButton addTarget:self action:@selector(testAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:testButton];
}



#pragma mark - 测试接口点击事件
- (void)testAction
{
    TestInterfaceVC *testInterfaceVC = [[TestInterfaceVC alloc] init];
    [self.navigationController pushViewController:testInterfaceVC animated:YES];
}



#pragma mark - 分享app的按钮
- (void)shareItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareTLStarAction)];
}



#pragma mark - 分享app的点击事件
- (void)shareTLStarAction
{
    YYLog(@"分享app给朋友");
}



#pragma mark - 搜索框
- (void)addSearchController
{
    self.search = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.search.searchResultsUpdater = self;
    self.search.dimsBackgroundDuringPresentation = false;
    [self.search.searchBar sizeToFit];
    self.search.searchBar.placeholder = @"搜索商品";
    self.navigationItem.titleView = self.search.searchBar;
    
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",self.search.searchBar.text];
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
























//
//  HomePageTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HomePageTableVC.h"
#import "NewestActivityTableVC.h" // 最新活动头文件

#import "TestInterfaceVC.h"

@interface HomePageTableVC ()<UISearchResultsUpdating,SDCycleScrollViewDelegate>

// 搜索框
@property (nonatomic,strong) UISearchController *search;
// scrollView
@property (nonatomic,strong) SDCycleScrollView *scrollView;
// 轮播图
@property (nonatomic,strong) UIView *headerView;

@end

@implementation HomePageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchController];// 添加搜索框
    
    [self shareItem];// 分享app
    
    [self creatHeaderView];// 轮播图
    
    
    
    // 测试接口按钮
    UIButton *testButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    testButton.frame = CGRectMake(50, 100, 100, 44);
    [testButton setTitle:@"测试接口" forState:(UIControlStateNormal)];
    [testButton addTarget:self action:@selector(testAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:testButton];

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



#pragma mark - 轮播图
- (void)creatHeaderView
{
    UIImage *image1 = [UIImage imageNamed:@"lunbo1"];
    UIImage *image2 = [UIImage imageNamed:@"lunbo2"];
    UIImage *image3 = [UIImage imageNamed:@"lunbo3"];
    NSArray *imagesArray = @[image1,image2,image3];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight)];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 0.25 * KScreenHeight) imageNamesGroup:imagesArray];
    _scrollView.delegate = self;
    _scrollView.placeholderImage = [UIImage imageNamed:@"lunbo2"];
    [_headerView addSubview:_scrollView];
    self.tableView.tableHeaderView = _headerView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



#pragma mark - 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0)
    {
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
            
        }
        
        cell.textLabel.text = @"最新活动";
        cell.textLabel.textAlignment = 1;
        
        return cell;

    }
    else
    {
        static NSString *identifier1 = @"cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
            
        }
        
        cell.textLabel.text = @"12345";
        
        return cell;

    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NewestActivityTableVC *newestActivityTableVC = [[NewestActivityTableVC alloc] initWithStyle:(UITableViewStylePlain)];
        [self.navigationController pushViewController:newestActivityTableVC animated:YES];
    }
}



@end







































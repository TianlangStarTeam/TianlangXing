//
//  StorageManagementTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementTableVC.h"

#import "StorageManagementCell.h"

#import "StorageManagementModel.h"

#import "ProductPublishTableVC.h"

@interface StorageManagementTableVC ()

@property (nonatomic,strong) UISegmentedControl *segment;

@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) UIButton *bottomButton;

@property (nonatomic,strong) UIButton *selectButton;// 复选框

@property (nonatomic,strong) UIButton *allSelectButton;// 全选

@property (nonatomic,strong) UILabel *nameLabel;// 名称

@property (nonatomic,strong) UILabel *countLabel;// 库存

@property (nonatomic,strong) UILabel *statusLabel;// 状态

@property (nonatomic,strong) NSMutableArray *storageManagementArray;// 接收仓库管理返回的数据

@property (nonatomic,strong) NSMutableArray *mArray;

@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation StorageManagementTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = KBgColor;
    
    [self creatTitleView];// 导航栏的选择title
    
    [self creatHeaderView];
    
    [self creatBottomButton];
    
    [self creatFooterView];
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            [self pullOnLoadingWithType:1];
            [self dropdownRefreshWithType:1];
        }
            break;
        case 1:
        {
            [self pullOnLoadingWithType:2];
            [self dropdownRefreshWithType:2];
        }
            break;
            
        default:
            break;
    }
    
    [self fetchPutawayAndSoldOutDataActionWithType:1];
//    [self fetchPutawayAndSoldOutDataActionWithType:2];
    
    
    self.tableView.rowHeight = 70;
}


- (NSMutableArray *)mArray
{
    if (!_mArray)
    {
        _mArray = [NSMutableArray array];
    }
    
    return _mArray;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.bottomButton removeFromSuperview];
}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"上架",@"下架"]];
    self.segment.frame = CGRectMake(0, 10, 122, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.selectedSegmentIndex = 0;
//    self.segment.selectedSegmentIndex = 1;
    
    self.navigationItem.titleView = self.segment;
    
    
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
            YYLog(@"上架");
            [self fetchPutawayAndSoldOutDataActionWithType:1];
            break;
        case 1:
            YYLog(@"下架");
            [self fetchPutawayAndSoldOutDataActionWithType:2];
            break;
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
    });
}



- (void)creatHeaderView
{
    CGFloat top = 10;
    
    CGFloat headerViewHeight = 50;
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, headerViewHeight)];
    self.headerView.backgroundColor =  [UIColor colorWithRed:239.0 / 255.0 green:239.0 / 255.0 blue:244.0 / 255.0 alpha:1];
    
    
    CGFloat width = 50;
    
    CGFloat selectButtonX = 21;
    CGFloat selectButtonWidth = 22;
    CGFloat selectButtonY = headerViewHeight / 2 - (selectButtonWidth / 2);
    self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.selectButton.frame = CGRectMake(selectButtonX, selectButtonY, selectButtonWidth, selectButtonWidth);
    [self.selectButton setImage:[[UIImage imageNamed:@"unselected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [self.selectButton setImage:[[UIImage imageNamed:@"selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [self.selectButton addTarget:self action:@selector(allSelectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headerView addSubview:self.selectButton];
    

    
    CGFloat allSelectButtonX = selectButtonX + selectButtonWidth;
    self.allSelectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.allSelectButton.frame = CGRectMake(allSelectButtonX, top, width, Klength30);
    [self.allSelectButton setTitle:@"全选" forState:(UIControlStateNormal)];
    [self.allSelectButton setTitleColor:[UIColor colorWithRed:64.0 / 255.0 green:64.0 / 255.0 blue:64.0 / 255.0 alpha:1] forState:(UIControlStateNormal)];
    [self.allSelectButton.titleLabel setFont:Font12];
    [self.allSelectButton addTarget:self action:@selector(allSelectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headerView addSubview:self.allSelectButton];
    
    
    
    CGFloat nameLabelX = allSelectButtonX + width + 20;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, top, width, Klength30)];
    self.nameLabel.text = @"名称";
    [self.headerView addSubview:self.nameLabel];
    
    
    
    CGFloat countLabelX = nameLabelX + width + 60;
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countLabelX, top, width, Klength30)];
    self.countLabel.text = @"库存";
    [self.headerView addSubview:self.countLabel];
    
    
    
    CGFloat statusLabelX = countLabelX + width + 25;
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabelX, top, width, Klength30)];
    self.statusLabel.text = @"状态";
    [self.headerView addSubview:self.statusLabel];
    
    
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    self.countLabel.font = [UIFont systemFontOfSize:17];
    self.statusLabel.font = [UIFont systemFontOfSize:17];
    
    self.tableView.tableHeaderView = self.headerView;
}



// 全选按钮的点击事件
- (void)allSelectAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    self.allSelectButton.selected = !self.allSelectButton.selected;
    [self setBackgroundImageWithSelectAllButton:button.selected];
}


// 设置选中按钮的状态
- (void)setBackgroundImageWithSelectAllButton:(BOOL)select
{
    NSMutableArray *array = [NSMutableArray array];
    for (StorageManagementModel *model in self.storageManagementArray)
    {
        model.selectedBtn = select;
        [array addObject:model];
    }
    self.storageManagementArray = array;
    [self.tableView reloadData];
}



- (void)creatBottomButton
{
    CGFloat bottomButtonY = KScreenHeight - Klength44;
    self.bottomButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottomButton.frame = CGRectMake(0, bottomButtonY, KScreenWidth, Klength44);
    [self.bottomButton setTintColor:[UIColor whiteColor]];
    self.bottomButton.backgroundColor = [UIColor blueColor];
    [self.bottomButton addTarget:self action:@selector(putawayAndSoldOutAction) forControlEvents:(UIControlEventTouchUpInside)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomButton];
    
    switch (self.segment.selectedSegmentIndex)
    {
        case 0:
        {
            [self.bottomButton setTitle:@"上架" forState:(UIControlStateNormal)];
        }
            break;
        case 1:
        {
            [self.bottomButton setTitle:@"下架" forState:(UIControlStateNormal)];
        }
            break;
            
        default:
            break;
    }
}


- (void)putawayAndSoldOutAction
{
//    [self putawayAndSoldOutActionWithType:1];
    [self putawayAndSoldOutActionWithType:2];
}



- (void)fetchPutawayAndSoldOutDataActionWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    self.pageNum = 1;
    
    parmas[@"pageNum"]  = @(self.pageNum);
    parmas[@"pageSize"]  = @"10";
    NSString *type1 = [NSString stringWithFormat:@"%ld",type];
    parmas[@"type"] = type1;

    NSString *url = [NSString stringWithFormat:@"%@find/products/list?",uRL];
    
    [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"上下架商品信息返回：：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            self.storageManagementArray = [StorageManagementModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            if (self.storageManagementArray.count > 0)
            {
                self.pageNum++;
                [self.tableView reloadData];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"上下架商品信息错误：：%@",error);
        
    }];
}



// 上拉加载
- (void)pullOnLoadingWithType:(NSInteger)type
{
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
        parmas[@"pageNum"]  = @(self.pageNum);
        parmas[@"pageSize"]  = @"10";
        NSString *type1 = [NSString stringWithFormat:@"%ld",type];
        parmas[@"type"] = type1;
        
        NSString *url = [NSString stringWithFormat:@"%@find/products/list?",uRL];
        
        [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             YYLog(@"上下架商品信息返回：：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 NSArray *array = [NSArray array];
                 array = [StorageManagementModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                 [self.storageManagementArray addObjectsFromArray:array];
                 
                 [self.tableView reloadData];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             YYLog(@"上下架商品信息错误：：%@",error);
             
         }];

    }];
}



// 下拉刷新
- (void)dropdownRefreshWithType:(NSInteger)type
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [_storageManagementArray removeAllObjects];
        
        [self fetchPutawayAndSoldOutDataActionWithType:1];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}



- (void)putawayAndSoldOutActionWithType:(NSInteger)type
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"productIds"]  = @"1";
    NSString *shelves = [NSString stringWithFormat:@"%ld",type];
    parmas[@"shelves"]  = shelves;
    
    NSString *url = [NSString stringWithFormat:@"%@update/products/shelves?",uRL];

    [[AFHTTPSessionManager manager] GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"上架返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"上架错误：%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storageManagementArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    StorageManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[StorageManagementCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    StorageManagementModel *storageManagementModel = self.storageManagementArray[indexPath.row];
    
    YYLog(@"单元格的选中状态%d",storageManagementModel.selectedBtn);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.nameLabel.text = storageManagementModel.productname;
    cell.countLabel.text = [NSString stringWithFormat:@"%ld",storageManagementModel.inventory];
    cell.statusLabel.text = storageManagementModel.saleState;
    
    [cell.selectButtton addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}



// 选中按钮的点击事件
- (void)selectAction:(UIButton *)button
{
    button.selected = !button.selected;
    UIView *subview  = [button superview];
    
    if (![subview isKindOfClass:[UITableViewCell class]])
    {
        subview = [[button superview] superview];
    }
    if ([subview isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = (UITableViewCell *)subview;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        StorageManagementModel *storageManagementModel = self.storageManagementArray[path.row];
        storageManagementModel.selectedBtn = button.selected;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
    });
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductPublishTableVC *productPublishTableVC = [[ProductPublishTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    [self.navigationController pushViewController:productPublishTableVC animated:YES];
}



- (void)creatFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;

}



@end

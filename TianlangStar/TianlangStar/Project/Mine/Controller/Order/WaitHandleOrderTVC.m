//
//  WaitHandleOrderTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "WaitHandleOrderTVC.h"
#import "WaitHandleOrderCell.h"
#import "OrderModel.h"
#import "OkdetailOrderVC.h"

@interface WaitHandleOrderTVC ()

@end

@implementation WaitHandleOrderTVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrderInfo)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header isAutomaticallyChangeAlpha];

    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrderInfo)];
}



//下拉刷新--最新数据
-(void)loadNewOrderInfo
{


}

//上啦刷新加载更多
-(void)loadMoreOrderInfo
{
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    WaitHandleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[WaitHandleOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    OrderModel *model = [[OrderModel alloc] init];
    cell.orderModel = model;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"2016-11-23";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OkdetailOrderVC *vc = [[OkdetailOrderVC alloc] init];
        OrderModel *model = [[OrderModel alloc] init];
    vc.orderModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end

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
#import "BossOkdetailOrderVC.h"
#import "WaitOrderModel.h"

@interface WaitHandleOrderTVC ()

/** 接收到的数据 */
@property (nonatomic,strong) NSMutableArray *orderArr;


@end

@implementation WaitHandleOrderTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRefresh];

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
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    
    NSString *url = [NSString stringWithFormat:@"%@findorderinfoservlet",URL];
    
    YYLog(@"parmas---%@",parmas);
    [HttpTool post:url parmas:parmas success:^(id json)
    {
        [self.tableView.mj_header endRefreshing];
        self.orderArr = [WaitOrderModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
        [self.tableView reloadData];
        YYLog(@"json---%@",json);
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        YYLog(@"error---%@",error);
    }];

}

//上啦刷新加载更多
-(void)loadMoreOrderInfo
{
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.orderArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    WaitOrderModel *model = self.orderArr[section];

    return model.valueList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    WaitHandleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[WaitHandleOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    WaitOrderModel *model = self.orderArr[indexPath.section];
    OrderModel *orderM = model.valueList[indexPath.row];
    cell.orderModel = orderM;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WaitOrderModel *model = self.orderArr[section];
    NSString *date = nil;
    if (model.date)
    {
        date = [model.date substringToIndex:10];
    }
    return date;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitOrderModel *model = self.orderArr[indexPath.section];
    OrderModel *orderM = model.valueList[indexPath.row];
    BossOkdetailOrderVC *vc = [[BossOkdetailOrderVC alloc] init];
    vc.orderModel = orderM;
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end

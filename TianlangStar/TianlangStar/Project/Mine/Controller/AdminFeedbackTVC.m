//
//  AdminFeedbackTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AdminFeedbackTVC.h"
#import "FeedbackModel.h"

@interface AdminFeedbackTVC ()


/** 获取服务器返回的意见列表 */
@property (nonatomic,strong) NSMutableArray *feedbackArr;

/** 给服务器发送的当前页面 */
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation AdminFeedbackTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupRefresh];
    

}


//添加上下拉功能
-(void)setupRefresh
{

    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewFeedbackAction)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFeedbackAction)];

}



#pragma mark - 查询客户提交的意见列表

//下拉加载最新数据
- (void)loadNewFeedbackAction
{
    
    [self.tableView.mj_footer endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@findsuggestionlistservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.currentPage = 1;
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         
         YYLog(@"查询客户提交的意见列表返回：%@",json);
         self.currentPage++;
         NSMutableArray *arr = [FeedbackModel mj_keyValuesArrayWithObjectArray:json[@"obj"]];
         YYLog(@"%@",arr);
     } failure:^(NSError *error)
     {
         YYLog(@"%@",error);
     }];
}


//下拉加载最新数据
- (void)loadMoreFeedbackAction
{
    NSString *url = [NSString stringWithFormat:@"%@findsuggestionlistservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.currentPage = 1;
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         YYLog(@"查询客户提交的意见列表返回：%@",json);
         self.currentPage++;
         NSMutableArray *arr = [FeedbackModel mj_keyValuesArrayWithObjectArray:json[@"obj"]];
         YYLog(@"%@",arr);
     } failure:^(NSError *error)
     {
         YYLog(@"%@",error);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

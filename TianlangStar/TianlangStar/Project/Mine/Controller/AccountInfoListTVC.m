//
//  AccountInfoListTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//


// 缓存主目录
#define HSCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HSCache"]


#import "AccountInfoListTVC.h"
#import "AccountInfoCell.h"
#import "UserModel.h"
#import "AccountMTVC.h"
#import "HSDownloadManager.h"

#import "WebExcelVC.h"
#import "ExcelModel.h"

@interface AccountInfoListTVC ()<NSURLSessionDelegate,NSURLSessionDataDelegate>

/** 保存服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *allPeopleArray;


/** 顶部的lable数组 */
@property (nonatomic,strong) NSArray *titleArr;

/** 当前页面 */
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) NSURL *downloadURL;

@end

@implementation AccountInfoListTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addHeaderView];
    
    [self setupRefresh];
    
    [self rightItemExportExcel];

}



- (void)rightItemExportExcel
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导出" style:(UIBarButtonItemStylePlain) target:self action:@selector(exportExcelAction)];
}


- (void)exportExcelAction
{
    NSString *url = [NSString stringWithFormat:@"%@exportfileuserinfoservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"导出excel返回%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            YYLog(@"导出excel");
            
            NSString *obj = responseObject[@"obj"];
            
            YYLog(@"导出excel链接： http://192.168.1.113:8080/%@",obj);
            
            NSString *objString = [NSString stringWithFormat:@"http://192.168.1.113:8080/%@",obj];
            
            NSURL *uRL = [NSURL URLWithString:objString];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"导出" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
            {
                NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                
                AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:uRL];
                
                NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
                {
                    NSString *cachesPatch = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                    
                    NSString *patchs = [cachesPatch stringByAppendingPathComponent:response.suggestedFilename];
                    
                    return [NSURL fileURLWithPath:patchs];
                    
                } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)
                {
                    YYLog(@"response=  %@",response);
                    YYLog(@"下载的文件路径：filePath=  %@",filePath);// 下载的文件路径
                    YYLog(@"下载错误信息：%@",error);
                    
                    NSString *string = [filePath path];
                    
                    NSURL *url = [NSURL  URLWithString:string];
                    
                    [[UIApplication sharedApplication] openURL:url];
                }];
                
                [downloadTask resume];
            }];
            
            
            
            [[AlertView sharedAlertView] addAlertMessage:nil title:@"是否导出" okAction:okAction];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"导出excel失败%@",error);
    }];
}


// 获取caches文件路径
- (NSString *)cacheaPath
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}


#pragma mark====== 增加上下拉功能======
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUserInfoData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserInfoData)];
}





-(void)addHeaderView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
//    headView.backgroundColor = [UIColor redColor];
    
    NSArray *arr = @[@"手机号",@"等级",@"注册时间"];
    
    NSMutableArray *titleArr = [NSMutableArray array];
    
    
    CGFloat width = KScreenWidth / arr.count;
    
    for (NSInteger i = 0; i < arr.count ; i++)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.x = width * i;
        lable.y = 0;
        lable.width = width;
        lable.height = 44;
        lable.text = arr[i];
        lable.font = Font18;
        lable.textAlignment = NSTextAlignmentCenter;
        
        //做位置的微调
        switch (i)
        {
            case 0://手机号
            {
                lable.width += 20;
                lable.x += 10;
                break;
            }
            case 1://等级
            {
//                lable.width -= 20;
//                lable.x += 15;
                break;
            }
            case 2://注册时间
            {
                lable.x += 10;
                lable.textAlignment = NSTextAlignmentLeft;
                break;
            }
                
            default:
                break;
        }
        [titleArr addObject:lable];
        [headView addSubview:lable];
    }
    
    self.titleArr = titleArr;
    
    self.tableView.tableHeaderView = headView;
}




/** 增加下拉刷新 */
-(void)loadNewUserInfoData
{
    [self.tableView.mj_footer endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@viewallusersservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    self.currentPage  = 1;
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         [self.tableView.mj_header endRefreshing];
         NSLog(@"json----%@",json);
         self.currentPage++;
         self.allPeopleArray = [UserModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         YYLog(@"所有用户请求失败：%@",error);
         [self.tableView.mj_header endRefreshing];
     }];
    
}


/** 增加上拉加载更多 */
-(void)loadMoreUserInfoData
{
    [self.tableView.mj_header endRefreshing];
    NSString *url = [NSString stringWithFormat:@"%@viewallusersservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @(self.currentPage);
    
    YYLog(@"parameterss 上拉-%@",parameters);
    [HttpTool post:url parmas:parameters success:^(id json)
     {
         
         [self.tableView.mj_footer endRefreshing];
         NSLog(@"json----%@",json);
         NSArray *arr = [UserModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         if (arr.count > 0)
         {
             self.currentPage++;
             self.allPeopleArray = [NSMutableArray arrayWithArray:arr];
         }
         //刷新数据
         [self.tableView reloadData];
     } failure:^(NSError *error) {
         YYLog(@"所有用户请求失败：%@",error);
         [self.tableView.mj_footer endRefreshing];
     }];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPeopleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AccountInfoCell *cell = [AccountInfoCell cellWithTableView:tableView];
    UserModel *model = self.allPeopleArray[indexPath.row];
    cell.userModel = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma mark==== 添加左滑删除功能======
//添加编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//删除所做的动作
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";

}


//删除所做的动作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        /** 管理员删除用户 */
        UserInfo * userInfo = [UserInfo sharedUserInfo];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        UserModel *model = self.allPeopleArray[indexPath.row];
        params[@"sessionId"] = userInfo.RSAsessionId;
        params[@"id"] = model.ID;
        NSString *url = [NSString stringWithFormat:@"%@deleteusersevlet",URL];
        
        YYLog(@"params---%@",params);
        
        /*
         Int resultCode  1000表示成功
         Int resultCode  1007用户没有登录
         Int resultCode  1016用户没有权限
         Int resultCode  1019删除操作没有成功
         */
        [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"管理员删除用户返回---%@",responseObject);
             NSNumber *num = responseObject[@"resultCode"];
             NSInteger result = [num integerValue];
             switch (result)
             {
                 case 1000:
                     YYLog(@"删除成功");
                     break;
                 case 1007:
                     YYLog(@"没登录");
                     [HttpTool loginUpdataSession];
                     break;
                 case 1016:
                     YYLog(@"用户没有权限");
                     break;
                 case 1009:
                     YYLog(@"删除操作没有成功");
                     break;
                     
                 default:
                     break;
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"管理员创建用户失败---%@",error);
         }];

        
        
        

        [self.allPeopleArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


//点击跳转并赋值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel *model = self.allPeopleArray[indexPath.row];
    AccountMTVC *vc = [[AccountMTVC alloc] init];
    vc.userModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}








@end

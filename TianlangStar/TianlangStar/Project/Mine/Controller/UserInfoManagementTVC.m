//
//  UserInfoManagementTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/1.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "UserInfoManagementTVC.h"
#import "RSA.h"

@interface UserInfoManagementTVC ()


/** 接收服务器返回的数据 */
@property (nonatomic,strong) NSMutableArray *userArr;

@end

@implementation UserInfoManagementTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户信息管理";
    
    [self loadData];
}


-(void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserInfo * userInfo = [UserInfo sharedUserInfo];
    params[@"sessionId"] = userInfo.RSAsessionId;
    
    NSString *url = [NSString stringWithFormat:@"%@getallcustomerservlet",URL];

    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"管理员查询用户列表返回-responseObject---%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"管理员查询用户列表返回-error---%@",error);
        
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;


}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /**
     *  管理员创建新用户
     */
        UserInfo * userInfo = [UserInfo sharedUserInfo];
    NSString *password  = @"123456Aa";
    NSString *RsaPassword = [RSA encryptString:password publicKey:userInfo.publicKey];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"sessionId"] = userInfo.RSAsessionId;
    params[@"username "] = @"18092456614";
    params[@"value"] = RsaPassword;
    
    NSString *url = [NSString stringWithFormat:@"%@creatuserservlet",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"管理员创建用户返回---%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"管理员创建用户失败---%@",error);
         
     }];

}



@end

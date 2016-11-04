//
//  HomePageVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageVC.h"

#import "AlertView.h"
#import "RegistVC.h"
#import "ForgetPwdVC.h"
#import "UserInfo.h"
#import "LoginVC.h"
#import "CollectionModel.h"

@interface HomePageVC ()


@property (nonatomic,strong) UserInfo *userInfo;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectionButton;
/** 收藏状态 */
@property (nonatomic,assign) BOOL isCollection;
/** 收藏model */
@property (nonatomic,strong) CollectionModel *collectionModel;
/** 保存数据模型 */
@property (nonatomic,strong) NSMutableArray *collectionArray;
/** 保存已收藏所有商品id */
@property (nonatomic,strong) NSMutableArray *collectionIdArray;


/** 添加收藏 */
@property (nonatomic,strong) UIButton *addCollectionButton;
/** 取消收藏 */
@property (nonatomic,strong) UIButton *cancleCollectionButton;
/** 获取全部收藏物 */
@property (nonatomic,strong) UIButton *allCollectionButton;
/** 查看收藏物详情 */
@property (nonatomic,strong) UIButton *collectionDetailButton;
/** 修改个人信息 */
@property (nonatomic,strong) UIButton *changePersonalInfoButton;



@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [UserInfo sharedUserInfo];
    self.collectionModel = [[CollectionModel alloc] init];
    
    // 登录
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:(UIBarButtonItemStylePlain) target:self action:@selector(loginAction)];
    
    
    
    // 收藏
    self.collectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collectionButton.frame = CGRectMake(50, 80, 80, 44);
    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    [self.collectionButton addTarget:self action:@selector(collectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.collectionButton];
    
    
    
    // 添加收藏
    self.addCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addCollectionButton.frame = CGRectMake(50, 130, 100, 44);
    [self.addCollectionButton setTitle:@"添加收藏" forState:(UIControlStateNormal)];
    [self.addCollectionButton addTarget:self action:@selector(addCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.addCollectionButton];
    
    
    
    // 取消收藏
    self.cancleCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.cancleCollectionButton.frame = CGRectMake(50, 180, 100, 44);
    [self.cancleCollectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
    [self.cancleCollectionButton addTarget:self action:@selector(cancleCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.cancleCollectionButton];
    
    
    
    // 获取指定用户的全部收藏物
    self.allCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.allCollectionButton.frame = CGRectMake(50, 230, 100, 44);
    [self.allCollectionButton setTitle:@"用户全部收藏" forState:(UIControlStateNormal)];
    [self.allCollectionButton addTarget:self action:@selector(allCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.allCollectionButton];
    
    
    
    // 查看收藏物详情
    self.collectionDetailButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collectionDetailButton.frame = CGRectMake(50, 280, 100, 44);
    [self.collectionDetailButton setTitle:@"收藏物详情" forState:(UIControlStateNormal)];
    [self.collectionDetailButton addTarget:self action:@selector(collectionDetailAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.collectionDetailButton];
    
    
    
    // 修改个人信息
    self.changePersonalInfoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.changePersonalInfoButton.frame = CGRectMake(50, 330, 100, 44);
    [self.changePersonalInfoButton setTitle:@"修改个人信息" forState:(UIControlStateNormal)];
    [self.changePersonalInfoButton addTarget:self action:@selector(changePersonalInfoAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.changePersonalInfoButton];
    
}



/**
 *  登录的点击事件
 */
- (void)loginAction
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



/**
 *  收藏的点击事件
 */
- (void)collectionAction
{
    if (self.userInfo.isLogin)
    {
        [self allCollectionAction];
        
        // 收藏过的数据里包含这个id则取消收藏
        if ([self.collectionArray containsObject:self.collectionModel.ID])
        {
            // 取消收藏
            [self cancleCollectionAction];
            
        }
        // 否则添加收藏
        else
        {
            // 添加收藏
            [self addCollectionAction];
            
        }
    }
    else
    {
        // 提示用户先登录
        [[AlertView sharedAlertView] loginAction];
    }
}



/**
 *  添加收藏的点击事件
 */
- (void)addCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@addtocollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"添加收藏请求成功-%@",responseObject);

        [[AlertView sharedAlertView] addAfterAlertMessage:@"收藏成功" title:@"提示"];
        
        [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
        
        self.isCollection = YES;

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏请求失败-%@",error);
        
    }];
}



/**
 *  取消收藏的点击事件
 */
- (void)cancleCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求成功-%@",responseObject);
        
        [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
        
        [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
        
        self.isCollection = NO;

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"取消收藏请求失败-%@",error);
        
    }];
}



/**
 *  获取指定用户的全部收藏物的点击事件
 */
- (void)allCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    YYLog(@"parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求成功-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000)
        {
            //保存模型数组，覆盖原有数组
            self.collectionArray = [CollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"obj"]];
            
            [self.collectionIdArray addObject:self.collectionModel.ID];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}



/**
 *  查看收藏物详情的点击事件
 */
- (void)collectionDetailAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"collectid"] = @"1";
    parameters[@"type"] = @"1";// 收藏物的类型(1 商品 2 服务)
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"查看收藏物详情数据请求成功-%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"查看收藏物详情数据请求失败-%@",error);
        
    }];
}



/**
 *  修改个人信息的点击事件
 */
- (void)changePersonalInfoAction
{
    NSString *url = [NSString stringWithFormat:@"%@updateuserinfoservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"oldheaderpic"] = @"picture/first/siju01.jpg";
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"修改个人信息数据请求成功-%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"修改个人信息数据请求失败-%@",error);
        
    }];
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
























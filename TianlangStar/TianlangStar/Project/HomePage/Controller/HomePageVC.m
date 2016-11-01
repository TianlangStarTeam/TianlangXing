//
//  HomePageVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageVC.h"

#import "RegistVC.h"
#import "ForgetPwdVC.h"

@interface HomePageVC ()

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
    
    
    // 添加收藏
    self.addCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addCollectionButton.frame = CGRectMake(50, 100, 100, 44);
    [self.addCollectionButton setTitle:@"添加收藏" forState:(UIControlStateNormal)];
    [self.addCollectionButton addTarget:self action:@selector(addCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.addCollectionButton];
    
    
    
    // 取消收藏
    self.cancleCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.cancleCollectionButton.frame = CGRectMake(50, 150, 100, 44);
    [self.cancleCollectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
    [self.cancleCollectionButton addTarget:self action:@selector(cancleCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.cancleCollectionButton];
    
    
    
    // 获取指定用户的全部收藏物
    self.allCollectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.allCollectionButton.frame = CGRectMake(50, 200, 100, 44);
    [self.allCollectionButton setTitle:@"用户全部收藏" forState:(UIControlStateNormal)];
    [self.allCollectionButton addTarget:self action:@selector(allCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.allCollectionButton];
    
    
    
    // 查看收藏物详情
    self.collectionDetailButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collectionDetailButton.frame = CGRectMake(50, 250, 100, 44);
    [self.collectionDetailButton setTitle:@"收藏物详情" forState:(UIControlStateNormal)];
    [self.collectionDetailButton addTarget:self action:@selector(collectionDetailAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.collectionDetailButton];
    
    
    
    // 修改个人信息
    self.changePersonalInfoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.changePersonalInfoButton.frame = CGRectMake(50, 300, 100, 44);
    [self.changePersonalInfoButton setTitle:@"修改个人信息" forState:(UIControlStateNormal)];
    [self.changePersonalInfoButton addTarget:self action:@selector(changePersonalInfoAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.changePersonalInfoButton];
    
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
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求成功-%@",responseObject);
        
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
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求成功-%@",responseObject);
        
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
























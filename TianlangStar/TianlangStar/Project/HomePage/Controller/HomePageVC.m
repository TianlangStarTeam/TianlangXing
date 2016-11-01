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
    self.cancleCollectionButton.frame = CGRectMake(50, 200, 100, 44);
    [self.cancleCollectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
    [self.cancleCollectionButton addTarget:self action:@selector(cancleCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.cancleCollectionButton];
    
}
/**
 *  添加收藏的点击事件
 */
- (void)addCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@addtocollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionid"] = sessionid;
    parameters[@"id"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"添加收藏成功-%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏失败-%@",error);
        
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
    
    YYLog(@"参数-%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏成功-%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"取消收藏失败-%@",error);
        
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
























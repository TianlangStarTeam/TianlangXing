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
    self.addCollectionButton.frame = CGRectMake(30, 100, 100, 44);
    [self.addCollectionButton setTitle:@"添加收藏" forState:(UIControlStateNormal)];
    [self.addCollectionButton addTarget:self action:@selector(collectionAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.addCollectionButton];
    
}
/**
 *  添加收藏的点击事件
 */
- (void)collectionAction
{
//    NSString const *URL = @"http://192.168.1.118:8080/carservice/";

    NSString *url = [NSString stringWithFormat:@"%@addtocollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"添加收藏成功-%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏失败-%@",error);
        
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
























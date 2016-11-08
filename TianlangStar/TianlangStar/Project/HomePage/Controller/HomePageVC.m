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
#import "UserModel.h"

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

/** 保存所有用户的数组 */
@property (nonatomic,strong) NSArray *allPeopleArray;
/** 所有用户的数组 */
@property (nonatomic,strong) NSMutableArray *mAllPeopleUsernameArray;

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
/** 管理员创建新用户 */
@property (nonatomic,strong) UIButton *creatNewPersonButton;
/** 管理员查询所有用户 */
@property (nonatomic,strong) UIButton *allPeopleButton;
/** 管理员删除用户 */
@property (nonatomic,strong) UIButton *deletePersonButton;
/** 查询客户提交的意见列表 */
@property (nonatomic,strong) UIButton *allFeedbackButton;
/** 客户提交意见 */
@property (nonatomic,strong) UIButton *handFeedbackButton;


@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [UserInfo sharedUserInfo];
    self.collectionModel = [[CollectionModel alloc] init];
    self.collectionIdArray = [NSMutableArray array];
    self.mAllPeopleUsernameArray = [NSMutableArray array];
    
    [self allCollectionAction];
    
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

    
    
    // 管理员创建新用户
    self.creatNewPersonButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.creatNewPersonButton.frame = CGRectMake(50, 380, 100, 44);
    [self.creatNewPersonButton setTitle:@"创建新用户" forState:(UIControlStateNormal)];
    [self.creatNewPersonButton addTarget:self action:@selector(creatNewPersonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.creatNewPersonButton];

    
    
    // 管理员查询所有用户
    self.allPeopleButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.allPeopleButton.frame = CGRectMake(50, 430, 100, 44);
    [self.allPeopleButton setTitle:@"所有用户" forState:(UIControlStateNormal)];
    [self.allPeopleButton addTarget:self action:@selector(allPeopleAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.allPeopleButton];


    
    
    // 管理员删除用户
    self.deletePersonButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.deletePersonButton.frame = CGRectMake(50, 480, 100, 44);
    [self.deletePersonButton setTitle:@"删除用户" forState:(UIControlStateNormal)];
    [self.deletePersonButton addTarget:self action:@selector(deletePersonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.deletePersonButton];
    
    
    
    // 查询客户提交的意见列表
    self.allFeedbackButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.allFeedbackButton.frame = CGRectMake(50, 530, 100, 44);
    [self.allFeedbackButton setTitle:@"客户意见列表" forState:(UIControlStateNormal)];
    [self.allFeedbackButton addTarget:self action:@selector(allFeedbackAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.allFeedbackButton];

    
    
    // 客户提交意见
    self.handFeedbackButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.handFeedbackButton.frame = CGRectMake(50, 580, 100, 44);
    [self.handFeedbackButton setTitle:@"客户提交意见" forState:(UIControlStateNormal)];
    [self.handFeedbackButton addTarget:self action:@selector(handFeedbackAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.handFeedbackButton];

    
}



/**
 *  登录的点击事件
 */
- (void)loginAction
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



#pragma mark - 管理员创建新用户
- (void)creatNewPersonAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcustomerservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        self.allPeopleArray = responseObject[@"obj"];
        
        UserModel *userModel = [[UserModel alloc] init];
        
        if (resultCode == 1000) {
            
            YYLog(@"成功");
            
            for (NSDictionary *dic in self.allPeopleArray)
            {
                [userModel setValuesForKeysWithDictionary:dic];
                [self.mAllPeopleUsernameArray addObject:userModel.username];
            }
            
            if (![self.mAllPeopleUsernameArray containsObject:@"蓓蓓"])
            {
                NSString *url = [NSString stringWithFormat:@"%@creatuserservlet",URL];
                
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                
                NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
                parameters[@"sessionId"] = sessionid;
                parameters[@"username"] = @"蓓蓓";
                NSString *password = [RSA encryptString:@"123qwe" publicKey:[UserInfo sharedUserInfo].publicKey];
                parameters[@"value"] = password;
                
                [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    YYLog(@"创建新用户返回：%@",responseObject);
                    
                    NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
                    
                    if (resultCode == 1000)
                    {
                        [[AlertView sharedAlertView] addAfterAlertMessage:@"创建成功" title:@"提示"];
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    YYLog(@"创建新用户返回失败：%@",error);
                }];
            }
            else
            {
                [[AlertView sharedAlertView] addAfterAlertMessage:@"用户已存在" title:@"提示"];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"所有用户请求失败：%@",error);
    }];
}



#pragma mark - 管理员查询所有用户
- (void)allPeopleAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcustomerservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;

    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"所有用户：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        self.allPeopleArray = responseObject[@"obj"];
        
        UserModel *userModel = [[UserModel alloc] init];
        
        if (resultCode == 1000) {
            
            YYLog(@"成功");
            
            for (NSDictionary *dic in self.allPeopleArray)
            {
                [userModel setValuesForKeysWithDictionary:dic];
                [self.mAllPeopleUsernameArray addObject:userModel];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"所有用户请求失败：%@",error);
    }];
}



#pragma mark - 管理员删除用户
- (void)deletePersonAction
{
    NSString *url = [NSString stringWithFormat:@"%@deleteusersevlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"id"] = @"23";

    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"管理员删除用户返回：%@",responseObject);
        
//        NSInteger resultCode = responseObject[@""];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"管理员删除用户请求失败：%@",error);
        
    }];
}



#pragma mark - 客户提交意见
- (void)handFeedbackAction
{
    NSString *url = [NSString stringWithFormat:@"%@addsuggestionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"userid"] = @"23";
    parameters[@"content"] = @"可以的厉害了我的哥棒棒哒好好好好好非常好不错可以厉害了我的哥棒棒哒好好好好好非常好";

    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"客户提交意见返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        YYLog(@"客户提交意见返回错误：%@",error);
    }];
}


#pragma mark - 查询客户提交的意见列表

- (void)allFeedbackAction
{
    NSString *url = [NSString stringWithFormat:@"%@findsuggestionlistservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"currentPage"] = @"1";

    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"查询客户提交的意见列表返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"查询客户提交的意见列表请求错误：%@",error);
    }];
}


#pragma mark - 收藏的点击事件
/**
 *  收藏的点击事件
 */
- (void)collectionAction
{
    if (self.userInfo.isLogin)
    {
        
        NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
        parameters[@"sessionId"] = sessionid;
        
        [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSNumber *num = responseObject[@"resultCode"];
            NSInteger result = [num integerValue];
            
            NSArray *array = responseObject[@"obj"];
            
            CollectionModel *collectionModel = [[CollectionModel alloc] init];

            if (result == 1000)
            {
                
                for (NSDictionary *dic in array) {
                    
                    [collectionModel setValuesForKeysWithDictionary:dic];
                    [self.collectionArray addObject:collectionModel];
                    [self.collectionIdArray addObject:collectionModel.productid];
                }
                
                YYLog(@"self.collectionModel.productid:%@",collectionModel.productid);
                
                // 收藏过的数据里包含这个id则取消收藏  collectionModel.productid
                if ([self.collectionIdArray containsObject:collectionModel.productid])
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
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
            
        }];
        
    }
    else
    {
        // 提示用户先登录
        [[AlertView sharedAlertView] loginAction];
    }
}



#pragma mark - 添加收藏
/**
 *  添加收藏
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
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];

        if (result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = YES;

            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAlertMessage:@"收藏失败" title:@"提示"];
            });
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"添加收藏请求失败-%@",error);
        
    }];
}



#pragma mark - 取消收藏
/**
 *  取消收藏
 */
- (void)cancleCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@canclecollectionservlet",URL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    parameters[@"productid"] = @"1";
    parameters[@"type"] = @"1";// 1:物品 2:服务
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"取消收藏请求成功-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];

        if (result == 1000) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏成功" title:@"提示"];
                
                [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
                
                self.isCollection = NO;

            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[AlertView sharedAlertView] addAfterAlertMessage:@"取消收藏失败" title:@"提示"];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"取消收藏请求失败-%@",error);
        
    }];
}



#pragma mark - 获取指定用户的全部收藏物
/**
 *  获取指定用户的全部收藏物的点击事件
 */
- (void)allCollectionAction
{
    NSString *url = [NSString stringWithFormat:@"%@getallcollectionservlet",URL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
    parameters[@"sessionId"] = sessionid;
    
    YYLog(@"sessionid===%@",sessionid);
    YYLog(@"获取指定用户的全部收藏物的parameters===%@",parameters);
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        YYLog(@"获取指定用户的全部收藏物请求成功-%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        NSArray *array = responseObject[@"obj"];
        
        CollectionModel *collectionModel = [[CollectionModel alloc] init];

        if (result == 1000)
        {
            for (NSDictionary *dic in array) {
                
                [collectionModel setValuesForKeysWithDictionary:dic];
                [self.collectionIdArray addObject:collectionModel.productid];
            }
            
            // 收藏过的数据里包含这个id则显示取消收藏 self.collectionModel.ID
            if ([self.collectionIdArray containsObject:collectionModel.productid])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 取消收藏
                    [self.collectionButton setTitle:@"取消收藏" forState:(UIControlStateNormal)];
                });
            }
            // 否则显示添加收藏
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    // 添加收藏
                    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];

                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YYLog(@"获取指定用户的全部收藏物请求失败-%@",error);
        
    }];
}



#pragma mark - 查看收藏物详情
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
























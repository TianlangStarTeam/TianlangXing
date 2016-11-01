//
//  MineVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"
#import "ForgetPwdVC.h"
#import "LoginView.h"


@interface MineVC ()

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否登录
    if (![UserInfo sharedUserInfo].isLogin)
    {
          [self getPubicKey];
    }


}


-(NSString *) getPubicKey
{
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendpubkeyservlet",URL];
    [[AFHTTPSessionManager manager]POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"公钥----%@",responseObject);
         UserInfo *userIn = [UserInfo sharedUserInfo];
         
         self.publicKey =responseObject[@"pubKey"];
         //若一开始从未从服务器获取到公钥，则从本地获取公钥
         if (_publicKey == nil )
         {
             self.publicKey = userIn.publicKey;
             YYLog(@"本地公钥%@",self.publicKey);
         }else
         {
             userIn.publicKey = self.publicKey;
             [userIn synchronizeToSandBox];
         }
         LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
         [self.view addSubview:logView];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"公钥获取失败---%@",error);
     }];
    
    return self.publicKey;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YYLog(@"86932");
    
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    YYLog(@"userInfo--%@",userInfo.username);
    YYLog(@"RSAsessionId-%@",userInfo.RSAsessionId);
    YYLog(@"%ld",(long)userInfo.userType);
    
    LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:logView];

}





@end

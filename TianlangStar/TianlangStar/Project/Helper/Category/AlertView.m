//
//  AlertView.m
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AlertView.h"
#import "LoginVC.h"

@interface AlertView ()

/** 当前界面的控制器 */
@property (nonatomic,strong) UIViewController *rootVC;

@end

@implementation AlertView

singleton_implementation(AlertView);

#pragma mark====懒加载=====

-(UIViewController *)rootVC
{
    if (!_rootVC)
    {
        _rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _rootVC;
}

///** 快速创建一个提示 */
//+(instancetype)alert
//{
//    AlertView *alert = [[self alloc] init];
//    return alert;
//}


/** 提示先登录 */
- (void)loginAlertView
{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录已过期，请重新登录！" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
       {
           
           LoginVC *loginVC = [[LoginVC alloc] init];
           loginVC.view.y = 64;
           [self.rootVC.navigationController pushViewController:loginVC animated:YES];
       }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [self.rootVC presentViewController:alert animated:YES completion:nil];
}



/** 自动登录 */
- (void)loginUpdataSession
{

    YYLog(@"自动登录");
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    NSString *password = [RSA encryptString:userInfo.passWord publicKey:userInfo.publicKey];
    //手机序列号的获取
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userInfo.username;
    params[@"value"] = password;
    //    params[@"code"] = self.captchaTF.text;
    
    params[@"terminal"] = uuid;
    //    params[@"terminal"] = @"421A6988-DA96-49FE-B99E-16820320F1BB";
    YYLog(@"自动登录---%@",params);
    
    //    YYLog(@"序列号%@",uuid);
    /*
     Int resultCode  1006 表示参数中有null
     Int resultCode  1007表示没有登录
     Int resultCode  1010表示用户密码与用户确认密码不同
     Int resultCode  1011 表示年龄不符合条件
     Int resultCode  1013  表示用户名在数据库中已经存在
     Int resultCode  1015  表示用户验证码不匹配
     Int resultCode  1003 密码错误
     1001数据库没有记录
     1014账户名重复
     */
    //设置这遮盖
    
    [SVProgressHUD showWithStatus:@"正在自动登录中~"];
    
    NSString *url = [NSString stringWithFormat:@"%@userservlet?movtion=1",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {         //进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //1.移除遮盖
         [SVProgressHUD dismiss];
         
         YYLog(@"更新登录返回--%@",responseObject);
         
         NSNumber *resultCode = responseObject[@"resultCode"];
         int result = [resultCode intValue];
         //2.判断并处理服务器的返回值
         //3记录sessionID,和用户模型数据
         if (result == 1000)//如果登陆成功才能取出sessionID，否则为空报错
         {
             [UserInfo sharedUserInfo].isLogin = YES;
             
             //获取sessionId,并更新至本地
             NSNumber * mun = responseObject[@"obj"][@"sessionId"];
             userInfo.sessionId = [NSString stringWithFormat:@"%@",mun];
             userInfo.RSAsessionId = [RSA encryptString:userInfo.sessionId publicKey:userInfo.publicKey];
             
             [userInfo synchronizeToSandBox];
             
         }else
         {
             
             //用户名或者密码发生改变，提示用户重新登录
             [self loginAlertView];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD dismiss];
         [SVProgressHUD showErrorWithStatus:@"登录失败，请稍后再试！"];
         YYLog(@"登录失败----%@",error);
     }];

}



/**
 *  @param message 提示信息
 *  @param title   标题
 */
-(void)addAlertMessage:(NSString *)message title:(NSString *)title
{

    NSLog(@"%@",title);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }]];
    
    [self.rootVC presentViewController:alert animated:YES completion:^ {  }];

}






@end

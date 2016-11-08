//
//  AlertView.m
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AlertView.h"
#import "LoginVC.h"
#import "LoginView.h"

@interface AlertView ()

/** 当前界面的控制器 */
@property (nonatomic,strong) UIViewController *rootVC;

@property (nonatomic,strong) UIAlertController *alert;

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



/**
 *  跳转至登录界面
 */
- (void)jumpToLoginView
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    UITabBarController *tableBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tableBar.selectedViewController;
    [nav pushViewController:loginVC animated:YES];
}



/** 登录已过期提示先登录 */
- (void)loginAlertView
{

    self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录已过期，请重新登录！" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
       {
           [self jumpToLoginView];
       }];
    
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}



/**
 *  用户未登录提示用户登录
 */
- (void)loginAction
{
    self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
    {
        
        [self jumpToLoginView];
        
    }];
    
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
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
    params[@"username"] = userInfo.username;
    params[@"value"] = password;
    params[@"terminal"] = @"421A6988-DA96-49FE-B99E-16820320F1BB";
    
//        params[@"code"] = @"88080";
    
//    params[@"terminal"] = uuid

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
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/userlogin",URL];
    
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



// 获取验证码
-(void)getNumbers:(NSString *)iphoneNum
{
    //设置界面的按钮显示 根据自己需求设置
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = iphoneNum;
    YYLog(@"接收验证码的手机--%@",iphoneNum);
    
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendcheckcodeservlet",URL];
    [[AFHTTPSessionManager manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"验证码获取成功----%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"验证码获取失败----%@",error);
         
     }];
}


-(void)addAlertMessage:(NSString *)message title:(NSString *)title
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }]];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^ {  }];
}



/**
 *  提示框延迟几秒消失
 *
 *  @param message 提示内容
 *  @param title   标题
 */
- (void)addAfterAlertMessage:(NSString *)message title:(NSString *)title
{
    
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


/**
 *  取消和确定的两个提示框
 *
 *  @param message      提示的内容
 *  @param title        标题
 *  @param okAction     确定事件(事件在外部自定义)
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title okAction:(UIAlertAction *)okAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}







@end





























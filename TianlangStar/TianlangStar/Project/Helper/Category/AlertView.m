//
//  AlertView.m
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AlertView.h"
#import "LoginVC.h"

@implementation AlertView


/** 提示先登录 */
- (void)loginAlertView
{
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录已过期，请重新登录！" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
       {
           
           LoginVC *loginVC = [[LoginVC alloc] init];
           loginVC.view.y = 64;
           [root.navigationController pushViewController:loginVC animated:YES];
       }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [root presentViewController:alert animated:YES completion:nil];
}



/** 自动登录 */
- (void)loginUpdataSession
{

    YYLog(@"自动登录");
}



/**
 *  @param message 提示信息
 *  @param title   标题
 */
-(void)addAlertMessage:(NSString *)message title:(NSString *)title
{

    NSLog(@"%@",title);

}



@end

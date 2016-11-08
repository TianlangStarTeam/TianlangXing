//
//  HttpTool.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>


@interface HttpTool ()



@end

@implementation HttpTool


+ (void)post:(NSString *)url parmas:(NSDictionary *)parmas success:(void (^)(id json))success failure:(void(^) (NSError *error))failure
{
    //1，创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            if (success) {
                success(responseObject);
            }
        }else
        {
            [self checkReultCode:result];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (error)
         {
             failure(error);
         }
    }];
}


+(void)get:(NSString *)url parmas:(NSDictionary *)parmas success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1，创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *num = responseObject[@"resultCode"];
        NSInteger result = [num integerValue];
        
        if (result == 1000) {
            if (success) {
                success(responseObject);
            }
        }else
        {
            [self checkReultCode:result];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error)
        {
            failure(error);
        }
    }];



}



+(void)checkReultCode:(NSInteger )result
{

    switch (result) {

        case 1001:
        {
            YYLog(@"数据库没有这条数据");
            break;
        }
        case 1002:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁" title:@"提示"];
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"系统错误");
            break;
        }
        case 1003:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁" title:@"提示"];
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"密码错误");
            break;
        }
        case -1004:
        {
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"sql语句执行错误");
            break;
        }
        case 1005:
        {
            [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"未知错误");
            break;
        }
        case 1006:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"参数中有空");
            break;
        }
        case 1007:
        {
            //自定登录
            [[AlertView sharedAlertView] loginUpdataSession];
            break;
        }
        case 1008:
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码错误" title:@"提示"];
            YYLog(@"验证码错误");
            break;
        }
        case 1009:
        {
            [[AlertView sharedAlertView] loginUpdataSession];
            YYLog(@"登录IP不符");
            break;
        }
        case 1011:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            [[AlertView sharedAlertView] loginUpdataSession];
            YYLog(@"用户登录macid和本次请求macid不符");
            break;
        }
        case 1012:
        {
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@" 误差值过大");
            break;
        }
        case 1013:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁忙，请稍后再试" title:@"提示"];
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            YYLog(@"登录手机号改变");
            break;
        }
        case 1014:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"服务繁忙，请稍后再试" title:@"提示"];
            [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"数据库中已存在数据");
            break;
        }
        case 1015:
        {
            [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"验证码不匹配");
            break;
        }
        case 1016:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"用户没有权限");
            break;
        }
        case 1017:
        {
            //                [[AlertView sharedAlertView] addAlertMessage:@"验证码不匹配" title:@"提示"];
            //                                [SVProgressHUD showErrorWithStatus:@"数据库中已存在该数据"];
            YYLog(@"图片符合格式");
            break;
        }
        case 1018:
        {
            [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"操作没有成功");
            break;
        }
        case 1019:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"删除没有成功");
            break;
        }
        case 1020:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"修改操作没有成功");
            break;
        }
        case 1021:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"用户名在数据库中不存存在");
            break;
        }
        case 1022:
        {
            //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
            YYLog(@"请核对金额");
            break;
        }
        default:
            //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
            break;
    }
}






@end

//
//  AboutSettingTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/9.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AboutSettingTVC.h"
#import "ILSettingItem.h"
#import "ILSettingArrowItem.h"
#import "ILSettingGroup.h"
#import "FeedbackVC.h"



@interface AboutSettingTVC ()


/** 退出登录 */
@property (nonatomic,weak) UIButton *exitLoginButton;

@end

@implementation AboutSettingTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGroup];
    
    [self creatExitLoginView];
}



-(void)addGroup
{
    ILSettingItem *version = [ILSettingItem itemWithIcon:nil title:@"当前版本"];
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    version.subTitle = ver;
    
    ILSettingItem *cache = [ILSettingItem itemWithIcon:nil title:@"清理缓存"];
    cache.subTitle = [NSString stringWithFormat:@"%.2fM",[self getCache]];
    cache.option = ^{
        [self clearCache];
    };
    
    ILSettingItem *contact = [ILSettingItem itemWithIcon:nil title:@"联系我们"];
    contact.subTitle = @"029-87563668";
    contact.option = ^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://029-87563668"]];
    };
    
    ILSettingItem *opinion = [ILSettingArrowItem itemWithIcon:nil title:@"用户意见" destVcClass:[FeedbackVC class]];
    
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.items = @[version,cache,contact,opinion];
    
    [self.dataList addObject:group0];
}


#pragma mark - 创建底部的退出登录
- (void)creatExitLoginView
{
    UIView *exitLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    
    exitLoginView.backgroundColor = [UIColor whiteColor];
    
    UIButton *exitLoginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.exitLoginButton = exitLoginButton;
    exitLoginButton.frame = CGRectMake(0, 0, KScreenWidth, 44);
    [exitLoginButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [exitLoginButton addTarget:self action:@selector(exitLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
    [exitLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [exitLoginButton setTitleColor:[UIColor colorWithRed:0.702 green:0.007 blue:0.020 alpha:1.000] forState:(UIControlStateNormal)];
    
    if ([UserInfo sharedUserInfo].isQuit == NO)
    {
        [exitLoginView addSubview:exitLoginButton];
    }
    self.tableView.tableFooterView = exitLoginView;
}



//退出登录的点击事件处理
- (void)exitLoginAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             //退出登录
                             [self quitLogin];
                         }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}





/**
 *  退出登录的操作
 */
-(void)quitLogin
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    NSString * url = [NSString stringWithFormat:@"%@logoutservlet",URL];
    
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"退出登录--%@",json);
         [UserInfo sharedUserInfo].isLogin = NO;
         [[UserInfo sharedUserInfo] synchronizeToSandBox];
         //获取公钥并且弹出登录窗口
         
         [self.navigationController popViewControllerAnimated:YES];

     } failure:^(NSError *error)
     {
         YYLog(@"退出登录--%@",error);
     }];
}



#pragma mark - 获取缓存大小以及缓存的处理
/**
 *  获取缓存大小
 */
-(CGFloat)getCache
{
    NSInteger totalSize = [[SDImageCache sharedImageCache] getSize];
    
    float totalSizeM = totalSize/1024.0/1024.0;
    
    return totalSizeM;
}


/**
 *  清除缓存
 */
-(void)clearCache
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存？" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"清除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        //清除缓存
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        
        //缓存大小
        NSString *cache = [NSString stringWithFormat:@"%.2fM",[self getCache]];
        
        ILSettingGroup *group = self.dataList[0];
        ILSettingItem *item = group.items[1];
        item.subTitle = cache;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end

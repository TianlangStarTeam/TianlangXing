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
#import "UserInfoManagementTVC.h"
#import "ILSettingGroup.h"
#import "FeedbackVC.h"

#import "ILSettingArrowItem.h"
#import "CarInfoListVC.h"



@interface MineVC ()

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;

/** 单元格的左边的数组显示 */
@property (nonatomic,strong) NSArray *leftTitleArr;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否登录
    if (![UserInfo sharedUserInfo].isLogin)
    {
          [self getPubicKey];
    }

    [self addGroup0];
    [self addGroup1];
//
//        LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
//        [self.view addSubview:logView];


}


-(void)addGroup0
{
    // 0组
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:nil title:@"收藏" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *pointsFor = [ILSettingArrowItem itemWithIcon:nil title:@"积分兑换" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *address = [ILSettingArrowItem itemWithIcon:nil title:@"地址管理" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *orderquery = [ILSettingArrowItem itemWithIcon:nil title:@"订单查询" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *account = [ILSettingArrowItem itemWithIcon:nil title:@"账户管理" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *carInfochange = [ILSettingArrowItem itemWithIcon:nil title:@"车辆信息修改" destVcClass:[CarInfoListVC class]];
    ILSettingArrowItem *carInfoRegist = [ILSettingArrowItem itemWithIcon:nil title:@"车辆信息登记" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *prepaidRecords = [ILSettingArrowItem itemWithIcon:nil title:@"充值记录查询" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *CustomerService = [ILSettingArrowItem itemWithIcon:nil title:@"客服热线" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *feedback = [ILSettingArrowItem itemWithIcon:nil title:@"意见反馈" destVcClass:[FeedbackVC class]];
    
    
    ILSettingItem *tel = [ILSettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.header = @"第1组数据";
    group0.footer = @"第1组结尾";
    group0.items = @[collection,pointsFor,address,orderquery,account,carInfochange,carInfoRegist,prepaidRecords,CustomerService,feedback,tel];
    
    [self.dataList addObject:group0];
}


-(void)addGroup1
{
    
    // 1组
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:nil title:@"收藏" destVcClass:nil];
    
    ILSettingItem *tel = [ILSettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.header = @"第2组数据";
    group0.footer = @"第2组结尾";
    
    
    
    ILSettingItem *updata = [ILSettingArrowItem itemWithIcon:nil title:@"版本更新" destVcClass:nil];
    updata.option =^{
        // 1.显示蒙板
        [SVProgressHUD showWithStatus:@"正在检测更新。。。"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 2.隐藏蒙板
            [SVProgressHUD dismiss];
            
            // 3.提示用户
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有更新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
            // 显示UIAlertView
            [alert show];
            
        });
    };
    
    group0.items = @[collection,tel,updata];
    [self.dataList addObject:group0];
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


@end

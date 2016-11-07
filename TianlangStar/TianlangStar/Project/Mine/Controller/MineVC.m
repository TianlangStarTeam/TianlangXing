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
#import "CarInfoChangeVC.h"
#import "AddCarInfo.h"

#import "ILSettingArrowItem.h"
#import "CarInfoListVC.h"
#import "ResetPasword.h"



@interface MineVC ()<LoginViewDelegate>

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;

/** 单元格的左边的数组显示 */
@property (nonatomic,strong) NSArray *leftTitleArr;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.判断是否登录
    if (![UserInfo sharedUserInfo].isLogin)
    {
          [self getPubicKey];
    }
    
    //2.根据用户的类型选择对应的单元格列表
    if ([UserInfo sharedUserInfo].userType == 1)//管理员
    {
        [self addGroupAdmin];
        
    }else//普通用户
    {
        [self addGroupCustomer];
    }
}


#pragma mark======添加客户和管理员的数组的单元格数组======
/**
 *  普通客户
 */
-(void)addGroupCustomer
{
    // 0组
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:nil title:@"收藏" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *pointsFor = [ILSettingArrowItem itemWithIcon:nil title:@"积分兑换" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *address = [ILSettingArrowItem itemWithIcon:nil title:@"地址管理" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *orderquery = [ILSettingArrowItem itemWithIcon:nil title:@"订单查询" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *account = [ILSettingArrowItem itemWithIcon:nil title:@"账户管理" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *carInfochange = [ILSettingArrowItem itemWithIcon:nil title:@"车辆信息修改" destVcClass:[CarInfoListVC class]];
    ILSettingArrowItem *carInfoRegist = [ILSettingArrowItem itemWithIcon:nil title:@"车辆信息登记" destVcClass:[AddCarInfo class]];
    ILSettingArrowItem *prepaidRecords = [ILSettingArrowItem itemWithIcon:nil title:@"充值记录查询" destVcClass:[UserInfoManagementTVC class]];
    ILSettingArrowItem *CustomerService = [ILSettingArrowItem itemWithIcon:nil title:@"客服热线" destVcClass:[ResetPasword class]];
    ILSettingArrowItem *feedback = [ILSettingArrowItem itemWithIcon:nil title:@"意见反馈" destVcClass:[FeedbackVC class]];
    ILSettingArrowItem *quit = [ILSettingArrowItem itemWithIcon:nil title:@"退出" destVcClass:nil];
    //设置退出登录
    quit.option = ^{
        
        [self addQuitAlert];
    };
    
    
    ILSettingItem *tel = [ILSettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.header = @"第1组数据";
    group0.footer = @"第1组结尾";
    group0.items = @[collection,pointsFor,address,orderquery,account,carInfochange,carInfoRegist,prepaidRecords,CustomerService,feedback,tel,quit];
    
    [self.dataList addObject:group0];
}


/**
 *  管理员
 */
-(void)addGroupAdmin
{
    //管理员
    ILSettingArrowItem *PendingOrders = [ILSettingArrowItem itemWithIcon:nil title:@"待处理订单" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *SalesStatistics = [ILSettingArrowItem itemWithIcon:nil title:@"销售统计" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *GoodsReleased = [ILSettingArrowItem itemWithIcon:nil title:@"商品发布" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *informationRelease = [ILSettingArrowItem itemWithIcon:nil title:@"信息发布" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *orderquery = [ILSettingArrowItem itemWithIcon:nil title:@"订单查询" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *carInfochange = [ILSettingArrowItem itemWithIcon:nil title:@"车辆信息修改" destVcClass:[CarInfoListVC class]];
    
    ILSettingArrowItem *InfoRegister = [ILSettingArrowItem itemWithIcon:nil title:@"信息登记" destVcClass:[CarInfoListVC class]];
    
    ILSettingArrowItem *topup= [ILSettingArrowItem itemWithIcon:nil title:@"充值" destVcClass:[CarInfoListVC class]];
    
    ILSettingArrowItem *TopupQuery= [ILSettingArrowItem itemWithIcon:nil title:@"充值查询" destVcClass:[CarInfoListVC class]];
    
    ILSettingArrowItem *account = [ILSettingArrowItem itemWithIcon:nil title:@"账户管理" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *opinionQuery= [ILSettingArrowItem itemWithIcon:nil title:@"意见查询" destVcClass:[CarInfoListVC class]];
    
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:nil title:@"收藏" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *pointsFor = [ILSettingArrowItem itemWithIcon:nil title:@"积分兑换" destVcClass:[UserInfoManagementTVC class]];
    
    ILSettingArrowItem *address = [ILSettingArrowItem itemWithIcon:nil title:@"地址管理" destVcClass:[UserInfoManagementTVC class]];


    ILSettingArrowItem *levelDiscount = [ILSettingArrowItem itemWithIcon:nil title:@"等级打折定制" destVcClass:[AddCarInfo class]];

    ILSettingArrowItem *quit = [ILSettingArrowItem itemWithIcon:nil title:@"退出" destVcClass:nil];
    //设置退出登录
    quit.option = ^{
        //设置提示并判断用户是否确认退出
        [self addQuitAlert];
    };
    
    
    ILSettingItem *tel = [ILSettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    
    ILSettingGroup *group0 = [[ILSettingGroup alloc] init];
    group0.header = @"第1组数据";
    group0.footer = @"第1组结尾";
    group0.items = @[PendingOrders,SalesStatistics,GoodsReleased,informationRelease,orderquery,carInfochange,InfoRegister,topup,TopupQuery,account,opinionQuery,collection,pointsFor,address,levelDiscount,quit];
    
    [self.dataList addObject:group0];
}

#pragma mark=======获取公钥并登录======
/**
 *  获取公钥并提示登录
 */
-(void) getPubicKey
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
         logView.delegate = self;
         self.tableView.scrollEnabled = NO;
         [self.view addSubview:logView];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"公钥获取失败---%@",error);
     }];
}


#pragma mark=======退出登录的操作======

/**
 *  退出登录提示
 */
-(void)addQuitAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
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

  [[AFHTTPSessionManager manager]POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress)
    {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
   {
       YYLog(@"退出登录--%@",responseObject);
       
       NSNumber *num = responseObject[@"resultCode"];
       NSInteger result = [num integerValue];
       if (result == 1000)
       {
           [UserInfo sharedUserInfo].isLogin = NO;
           [[UserInfo sharedUserInfo] synchronizeToSandBox];

           //获取公钥并且弹出登录窗口
           [self getPubicKey];
       }else
       {
           [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试"];
       }

  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"退出登录--%@",error);
      
  }];

}


#pragma mark=======登录成功后调用代理，设置tableView上下滑动可用======
-(void)loginSuccess
{
    self.tableView.scrollEnabled = YES;
}


@end

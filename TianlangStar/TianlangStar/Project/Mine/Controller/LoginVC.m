//
//  LoginVC.m
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/********** 登录 **********/


#define Kver 0.04 * KScreenHeight
#define Khor 0.04 * KScreenWidth
#define KButtonHor (KScreenWidth - 2 * userNamePicX - 2 * registButtonWidth)
#define KRight 0.12 * KScreenWidth

#import "LoginVC.h"
#import "UserModel.h"
#import "XLXConst.h"
#import "AlertView.h"
#import "ForgetPwdVC.h"
#import "LoginView.h"





@interface LoginVC ()


/** 记录验证码按钮的点击事件是否可用 */
@property (nonatomic,assign) BOOL selectedBTN;

/** 用户模型 */
@property (nonatomic,strong) UserModel *userM;


/** 销售员 */
@property (nonatomic,strong) UIButton *button4;
/** 项目经理 */
@property (nonatomic,strong) UIButton *button5;
/** 销售经理 */
@property (nonatomic,strong) UIButton *button6;
/** passWorwTF */
@property (nonatomic,copy) NSString *sessionId;

/** 公钥 */
@property (nonatomic,copy) NSString *publicKey;


/** 记录确认的Y值 */
@property (nonatomic,assign) CGFloat okY;


/** 登录界面的背景的图片 */
@property (nonatomic,weak) UIImageView *bgImageView;


/** 注册 */
@property (nonatomic,weak) UIButton *regist;

@end

@implementation LoginVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";

    //获取公钥
    [self getPubicKey];
    
    [self setUpLogin];
}


/**
 *  获取公钥
 */
-(NSString *) getPubicKey
{
    NSString *url = [NSString stringWithFormat:@"%@unlogin/sendpubkeyservlet",URL];
    [[AFHTTPSessionManager manager]POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        YYLog(@"公钥----%@",responseObject);
        self.publicKey =responseObject[@"pubKey"];
        //若一开始从未从服务器获取到公钥，则从本地获取公钥
        if (_publicKey == nil )
        {
            UserInfo *userIn = [UserInfo sharedUserInfo];
            self.publicKey = userIn.publicKey;
            YYLog(@"本地公钥%@",self.publicKey);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
        YYLog(@"公钥获取失败---%@",error);
    }];
    
    return self.publicKey;
}


/**
 * 设置登录界面
 */
-(void)setUpLogin
{
    LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:logView];


}



/**
 *  核对并判断返回值
 */
-(void)checkResultCode:(int)result
{
    switch (result)
    {
        case 1000://登录成功
        {
            //0.设置用户提示
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            //1.保存用户名和密码到沙河
            UserInfo *userIn = [UserInfo sharedUserInfo];
            //加密过的sessionID
            NSString *RSASessionID  = [RSA encryptString:self.sessionId publicKey:self.publicKey];
            userIn.username = self.userNameTF.text;
            userIn.passWord = self.pwdTF.text;
            userIn.sessionId = self.sessionId;
            userIn.publicKey = self.publicKey;
            userIn.RSAsessionId = RSASessionID;
            userIn.userID = self.userM.ID;
            userIn.userType = [NSString stringWithFormat:@"%ld",(long)self.userM.type];
            userIn.headerpic = self.userM.headerpic;
            userIn.membername = self.userM.membername;
            
            [userIn synchronizeToSandBox];
            //2.界面跳转——>登录界面
            [self jupeToPage:self.userM];
            break;
        }
        case 1001://数据库中没有记录
        {
            YYLog(@"数据库中没有记录");
//            [self addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            [[AlertView sharedAlertView]addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
            break;
        }
        case 1003://密码错误
        {
            YYLog(@"用户密码错误");
//            [self addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            [[AlertView sharedAlertView]addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
            break;
        }
        case 1006://参数中有空
        {
            YYLog(@"参数中有空");

            [[AlertView sharedAlertView]addAlertMessage:@"输入有误，请核对！" title:@"提示"];
            return;
            break;
        }
        case 1010://表示用户密码与用户确认密码不同
        {
            YYLog(@"用户密码与用户确认密码不同");
            [[AlertView sharedAlertView]addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
        }
            
        case 1013://用户名在数据库中已经存在，需要发验码进行验证
        {
            [[AlertView sharedAlertView]addAlertMessage:@"登录设备发生改变，请输入验证码验证！" title:@"提示"];

            //            self.captchaTF.y = self.capY;
            self.regist.y = self.okY;
            self.foundPwdButton.y = self.okY;
            self.okButton.y = CGRectGetMaxY(self.regist.frame) + 20;
            
            self.captchaPic.hidden = NO;
            self.captchaTF.hidden = NO;
            self.captchaButton.hidden = NO;
            YYLog(@"用户名在数据库中已经存在");
            return;
            break;
        }
        case 1015://表示用户验证码不匹配
        {
            [[AlertView sharedAlertView]addAlertMessage:@"验证码错误！" title:@"提示"];
            return;
            break;
        }
        case 1014://表示用户验证码不匹配
        {
            [[AlertView sharedAlertView]addAlertMessage:@"此用户已存在！" title:@"提示"];
            return;
            break;
        }
        case 1016://用户没有权限
        {
            YYLog(@"表示用户验证码不匹配");
            [SVProgressHUD showErrorWithStatus:@"用户没有权限"];
            return;
            break;
        }
            
        default:
            break;
    }
}


/**
 *  跳转界面的判断并处理
 */
-(void)jupeToPage:(UserModel *)userM
{

    if (!userM)
    {
        YYLog(@"用户类型为空");
        return;
    }
    
    //判断是否为管理员
    if ([userM.ID isEqualToString:@"1"])
    {
//        YYLog(@"管理员");
//        
//        if ([self.delegate respondsToSelector:@selector(backEachElement:)])
//        {
//            [self.delegate backEachElement:1];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        return;
//        AdminVC *vc = [[AdminVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];

    }else//非管理员
    {
        
        if ([self.delegate respondsToSelector:@selector(backEachElement:)])
        {
            [self.delegate backEachElement:userM.type];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    
    }
    
}



- (void)alertView
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self performSelector:@selector(cancleAction) withObject:nil afterDelay:1];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

- (void)cancleAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^
     {
         [self.navigationController popToRootViewControllerAnimated:YES];
         
     }];
}

/**
 *  注册
 */
- (void)registAction
{
    YYLog(@"注册");
//    [self.pictureView endEditing:YES];
//    RegistVC *registVC = [[RegistVC alloc] init];
//    [self.navigationController pushViewController:registVC animated:YES];
    
}

/**
 *  忘记密码
 */
- (void)foundPwdAction
{
    YYLog(@"忘记密码");
    
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UINavigationController *nav = (UINavigationController *)window.rootViewController;
    UIViewController *viewController = [nav.viewControllers objectAtIndex:1];
    
        ForgetPwdVC *vc = [[ForgetPwdVC alloc] init];
    [viewController.navigationController pushViewController:vc animated:YES];
    

}


@end

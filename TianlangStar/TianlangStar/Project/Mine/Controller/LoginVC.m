//
//  LoginVC.m
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/********** 登录 **********/


#define Kver 0.04 * kHeight
#define Khor 0.04 * kWidth
#define KButtonHor (kWidth - 2 * userNamePicX - 2 * registButtonWidth)
#import "LoginVC.h"
#import "UserModel.h"
#import "XLXConst.h"




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
}


/**
 *  获取公钥
 */
-(NSString *) getPubicKey
{
    NSString *url = [NSString stringWithFormat:@"%@userservlet?movtion=4",URL];
    [[AFHTTPSessionManager manager]POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        YYLog(@"公钥----%@",responseObject);
        self.publicKey =responseObject[@"pubKey"];
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

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {

        
        // 用户名
        CGFloat userNamePicX = 0.12 * kWidth;
        CGFloat userNamePicY = kHeight * 0.05;
        CGFloat userNamePicWidth = 30;
        CGFloat userNamePicHeight = 30;
        self.userNamePic = [[UIImageView alloc] initWithFrame:CGRectMake(userNamePicX, userNamePicY, userNamePicWidth, userNamePicHeight)];
        self.userNamePic.image = [UIImage imageNamed:@"admin"];
        [self.view addSubview:self.userNamePic];
        
        // 输入用户名
        CGFloat userNameTFX = userNamePicX + userNamePicWidth + Khor;
        CGFloat userNameTFWidth = kWidth - userNamePicX - KRight - userNamePicWidth - Khor;
        self.userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(userNameTFX, userNamePicY, userNameTFWidth, userNamePicHeight)];
        self.userNameTF.borderStyle = TFborderStyle;
        self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;
        self.userNameTF.placeholder = @"请输入手机号";
        self.userNameTF.font = textFieldPlaceholderFont;
        self.userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:self.userNameTF];
        
        
        
        // 密码
        CGFloat pwdLabelY = userNamePicY + userNamePicHeight +  Kver;
        self.pwdPic = [[UIImageView alloc] initWithFrame:CGRectMake(userNamePicX, pwdLabelY, userNamePicWidth, userNamePicHeight)];
        self.pwdPic.image = [UIImage imageNamed:@"password"];
        [self.view addSubview:self.pwdPic];
        
        // 请输入密码
        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(userNameTFX, pwdLabelY, userNameTFWidth, userNamePicHeight)];
        self.pwdTF.borderStyle = TFborderStyle;
        self.pwdTF.placeholder = @"请输入密码";
        self.pwdTF.font = textFieldPlaceholderFont;
        self.pwdTF.secureTextEntry= YES;
        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:self.pwdTF];
        
        
        
        // 验证码
        CGFloat captchY = pwdLabelY + userNamePicHeight + Kver;
        self.captchaPic = [[UIImageView alloc] initWithFrame:CGRectMake(userNamePicX, captchY, userNamePicWidth, userNamePicHeight)];
        self.captchaPic.image = [UIImage imageNamed:@"yanzhengma"];
        [self.view addSubview:self.captchaPic];
        // 请输入验证码
        CGFloat captchaTFWidth = (kWidth - 2 * userNamePicX - userNamePicWidth - Khor) / 2;
        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(userNameTFX, captchY, captchaTFWidth, userNamePicHeight)];
        self.captchaTF.borderStyle = TFborderStyle;
        self.captchaTF.placeholder = @"请输入验证码";
        self.captchaTF.font = textFieldPlaceholderFont;
        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:self.captchaTF];
        
        // 点击确认验证码
        self.captchaButton = [[UIButton alloc] init];
        self.captchaButton.frame = CGRectMake(userNameTFX + captchaTFWidth, captchY, captchaTFWidth, userNamePicHeight);
        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.captchaButton.backgroundColor = buttonBG;
        self.captchaButton.layer.cornerRadius = BtncornerRadius;
        self.captchaButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.captchaButton setTitleColor:buttonTitleC forState:UIControlStateNormal];
        [self.view addSubview:self.captchaButton];
        
        self.captchaPic.hidden = YES;
        self.captchaTF.hidden = YES;
        self.captchaButton.hidden = YES;
        
        
        
        // 注册Button
        CGFloat registButtonWidth = 100;
        CGFloat registButtonX = userNamePicX;
        CGFloat registButtonY = captchY + userNamePicHeight + 40;
        CGFloat registButtonHeight = 30;
        
        CGFloat foundPwdX = registButtonX + registButtonWidth + KButtonHor;
        
        //        CGFloat okButtonX = (kWidth / 2) - 30;
        //        CGFloat okButtonY = registButtonY + registButtonHeight + 30;
        //        CGFloat okButtonWidth = 60;
        //        CGFloat okButtonHeight = 30;
        
        CGFloat okButtonX = userNamePicX;
        CGFloat okButtonY = captchY + userNamePicHeight + 15;
        
        self.okY = okButtonY;
        CGFloat okButtonWidth = 100;
        CGFloat okButtonHeight = 30;
        
        self.registButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.foundPwdButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.okButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        if ((self.captchaPic.hidden == YES) && (self.captchaTF.hidden == YES) && self.captchaButton.hidden == YES)
        {
            CGFloat registY = pwdLabelY + userNamePicHeight + 15;
            CGFloat okButtonY = pwdLabelY + registButtonHeight + 40;
            
            self.registButton.frame = CGRectMake(registButtonX, registY, registButtonWidth, registButtonHeight);
            self.foundPwdButton.frame = CGRectMake(foundPwdX, registY, registButtonWidth, registButtonHeight);
            self.okButton.frame = CGRectMake(okButtonX, okButtonY, okButtonWidth, okButtonHeight);
        }
        else
        {
            self.registButton.frame = CGRectMake(registButtonX, registButtonY, registButtonWidth, registButtonHeight);
            self.foundPwdButton.frame = CGRectMake(foundPwdX, registButtonY, registButtonWidth, registButtonHeight);
            self.okButton.frame = CGRectMake(okButtonX, okButtonY, okButtonWidth, okButtonHeight);
        }
        
        
        // 找回密码Button
        [self.foundPwdButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
        [self.foundPwdButton addTarget:self action:@selector(foundPwdAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.foundPwdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //        self.foundPwdButton.backgroundColor = buttonBG;
        //        [self.foundPwdButton setTintColor:buttonTitleC];
        [self.foundPwdButton setTintColor:[UIColor blackColor]];
        self.foundPwdButton.layer.cornerRadius = BtncornerRadius;
        [self.view addSubview:self.foundPwdButton];
        
        UIButton *regist = [UIButton buttonWithType:UIButtonTypeSystem];
        regist.x = self.userNamePic.x;
        regist.y = self.foundPwdButton.y;
        regist.width = self.foundPwdButton.width;
        regist.height = self.foundPwdButton.height;
        [regist setTitle:@"新用户注册" forState:UIControlStateNormal];
        [regist addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
        //        regist.backgroundColor = buttonBG;
        //        [regist setTintColor:buttonTitleC];
        [regist setTintColor:[UIColor blackColor]];
        regist.layer.cornerRadius = BtncornerRadius;
        self.regist = regist;
        [self.view addSubview:regist];
        
        
        // 确认Button
        [self.okButton setTitle:@" 确 定 " forState:(UIControlStateNormal)];
        [self.okButton addTarget:self action:@selector(okAction) forControlEvents:(UIControlEventTouchUpInside)];
        //        self.okButton.backgroundColor = [UIColor colorWithRed:31/255.0 green:42/255.0 blue:70/255.0 alpha:1.000];
        self.okButton.backgroundColor = buttonBG;
        self.okButton.layer.cornerRadius = BtncornerRadius;
        [self.okButton setTintColor:buttonTitleC];
        self.okButton.y = CGRectGetMaxY(self.foundPwdButton.frame) + 20;
        self.okButton.width = kWidth * 0.65;
        self.okButton.centerX = kWidth *0.5;
        [self.view addSubview:self.okButton];

    }
    return self;
}


/** 发送验证码点击按钮 */
-(void)captchaAction
{
    //判断手机号输入是否正确
    if (![self.userNameTF.text isMobileNumber])
    {
//        [self addAlertMessage:@"手机号输入有误，请核对！" title:@"提示"];
        return;
    }
    
    //判断验证码是否可用，第一次进入时调用
    if (!self.selectedBTN)
    {
//        [self getNumbers:self.userNameTF.text];
    }
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
    if(timeout<=0)
    { //倒计时结束，关闭
    dispatch_source_cancel(_timer);
    dispatch_async(dispatch_get_main_queue(), ^
    {
    //记录按钮的是否可以点击事件
    self.selectedBTN = NO;
    [self.captchaButton setTitle:@"重发验证码" forState:UIControlStateNormal];
    self.captchaButton.userInteractionEnabled = YES; });
    }else
    {
    int seconds = timeout % 60;
    self.selectedBTN = YES;

    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
    dispatch_async(dispatch_get_main_queue(), ^
         {
             //设置界面的按钮显示 根据自己需求设置
             //        YYLog(@"____%@",strTime);
             self.selectedBTN = YES;
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:1];
             [self.captchaButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
             [UIView commitAnimations];
             self.captchaButton.userInteractionEnabled = NO;
         });
    timeout--;
    }
    });
    dispatch_resume(_timer);
}








//登录按钮的点击事件
- (void)okAction
{
    [self.view endEditing:YES];

    //判断用户输入数据的合法性
    if ( ![self.userNameTF.text isMobileNumber])
    {
//        [self addAlertMessage:@"用户名为手机号，请核对！" title:@"提示"];
        return;
    }
    
    if (! (self.pwdTF.text.length >5 && self.pwdTF.text.length <33) )
    {
//        [self addAlertMessage:@"密码错误，请输入6-32位密码！" title:@"提示"];
        return;
    }

//    if (![self.pwdTF.text isLegalInput])
//    {
//        [self addAlertMessage:@"密码为数字加字母组合" title:@"提示！"];
//    }

    
    //拼接参数
    //rsa加密
    NSString *password = [RSA encryptString:self.pwdTF.text publicKey:self.publicKey];
    //手机序列号的获取
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = self.userNameTF.text;
    params[@"value"] = password;
    params[@"code"] = self.captchaTF.text;

    params[@"terminal"] = uuid;
//    params[@"terminal"] = @"421A6988-DA96-49FE-B99E-16820320F1BB";
    YYLog(@"%@",params);

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
    
    [SVProgressHUD showWithStatus:@"正在登录"];

    NSString *url = [NSString stringWithFormat:@"%@userservlet?movtion=1",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {         //进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //1.移除遮盖
         [SVProgressHUD dismiss];
         
         YYLog(@"登录返回--%@",responseObject);
         
         NSNumber *resultCode = responseObject[@"resultCode"];
         int result = [resultCode intValue];
         //2.判断并处理服务器的返回值
         //3记录sessionID,和用户模型数据
         if (result == 1000)//如果登陆成功才能取出sessionID，否则为空报错
         {
             [UserInfo sharedUserInfo].isLogin = YES;
             
             //获取sessionId
             NSNumber * mun = responseObject[@"obj"][@"sessionId"];
             self.sessionId = [NSString stringWithFormat:@"%@",mun];
             
             //获取用户类型字典
             NSDictionary * type1 = responseObject[@"obj"][@"user"];
             //取出字典中的用户类型——转模型
//             self.userM = [UserModel mj_objectWithKeyValues:type1];
             [SVProgressHUD  showSuccessWithStatus:@"登录成功"];
         }
         
         //4.处理返回结果。跳对应的界面
         [self checkResultCode:result];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD dismiss];
         [SVProgressHUD showErrorWithStatus:@"登录失败，请稍后再试！"];
         YYLog(@"登录失败----%@",error);
     }];
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
            //            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
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
            userIn.employeeName = self.userM.employeeName;
            
            [userIn synchronizeToSandBox];
            //2.界面跳转——>登录界面
            [self jupeToPage:self.userM];
            break;
        }
        case 1001://数据库中没有记录
        {
            YYLog(@"数据库中没有记录");
//            [self addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
            break;
        }
        case 1003://密码错误
        {
            YYLog(@"用户密码错误");
//            [self addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
            break;
        }
        case 1006://参数中有空
        {
            YYLog(@"参数中有空");
//            [self addAlertMessage:@"输入有误，请核对！" title:@"提示"];
            return;
            break;
        }
        case 1010://表示用户密码与用户确认密码不同
        {
            YYLog(@"用户密码与用户确认密码不同");
//            [self addAlertMessage:@"用户名或密码错误！" title:@"提示"];
            return;
        }
            
        case 1013://用户名在数据库中已经存在，需要发验码进行验证
        {
//            [self addAlertMessage:@"登录设备发生改变，请输入验证码验证！" title:@"提示"];
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
//            [self addAlertMessage:@"验证码错误！" title:@"提示"];
            return;
            break;
        }
        case 1014://表示用户验证码不匹配
        {
//            [self addAlertMessage:@"此用户已存在！" title:@"提示"];
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
//    [self.pictureView endEditing:YES];
//    RegistVC *registVC = [[RegistVC alloc] init];
//    [self.navigationController pushViewController:registVC animated:YES];
    
}

/**
 *  忘记密码
 */
- (void)foundPwdAction
{
//    FindPwdVC *findPwdVC = [[FindPwdVC alloc] init];
//    
//    [self.navigationController pushViewController:findPwdVC animated:YES];
}


@end

//
//  FindPwdVC.m
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//
/********** 找回密码 **********/


#define Kver 0.04 * KScreenHeight
#define Khor 0.02 * KScreenWidth
#define KRight 0.12 * KScreenWidth
#import "FindPwdVC.h"
#import "RSA.h"
#import <AFNetworking.h>
#import "UserInfo.h"

@interface FindPwdVC ()

/** 验证码是否可用 */
@property (nonatomic,assign) BOOL selectedBTN;

@end

@implementation FindPwdVC

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.title = @"忘记密码";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
//    UserInfo *userIn = [UserInfo sharedUserInfo];

}


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        self.pictureView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.pictureView.image = [UIImage imageNamed:@"Background"];
        self.pictureView.userInteractionEnabled = YES;
        [self.view addSubview:self.pictureView];
        
        // 手机号
        CGFloat telLableX = 0.12 * KScreenWidth;
        CGFloat telLableY = KScreenHeight * 0.15;
        CGFloat telLableWidth = 75;
        CGFloat telLableHeight = 30;
//        self.telphoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, telLableY, telLableWidth, telLableHeight)];
        self.telphoneLabel = [[UILabel alloc] init];
        [self.view addSubview:self.telphoneLabel];
        [self.telphoneLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(telLableX);
            make.top.mas_equalTo(telLableY);
            make.size.mas_equalTo(CGSizeMake(telLableWidth, telLableHeight));
            
        }];
        self.telphoneLabel.text = @"手机号";
        self.telphoneLabel.font = Font16;
        // 输入手机号
        CGFloat telX = telLableWidth + Khor;
        CGFloat telWidth = KScreenWidth - telLableX - telLableWidth - Khor - KRight;
//        self.telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, telLableY, telWidth, telLableHeight)];
        self.telphoneTF = [[UITextField alloc] init];
        [self.view addSubview:self.telphoneTF];
        [self.telphoneTF mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneLabel.mas_left).with.offset(telX);
            make.top.mas_equalTo(self.telphoneLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(telWidth, telLableHeight));
            
        }];
        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.telphoneTF.placeholder = @"请输入手机号";
        self.telphoneTF.font = Font14;
        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.telphoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.telphoneTF.borderStyle = TFborderStyle;
        
        
        
        
        // 验证码
        CGFloat captchaLabelY = telLableHeight + Kver;
//        self.captchaLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, captchaLabelY, telLableWidth, telLableHeight)];
        self.captchaLabel = [[UILabel alloc] init];
        [self.view addSubview:self.captchaLabel];
        [self.captchaLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneLabel.mas_left);
            make.top.mas_equalTo(self.telphoneLabel.mas_top).with.offset(captchaLabelY);
            make.size.mas_equalTo(CGSizeMake(telLableWidth, telLableHeight));
            
        }];
        self.captchaLabel.text = @"验证码";
        self.captchaLabel.font = Font16;
        // 输入验证码
//        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaLabelY, telWidth, telLableHeight)];
        CGFloat captchaTFWidth = telWidth / 2;
        self.captchaTF = [[UITextField alloc] init];
        [self.view addSubview:self.captchaTF];
        [self.captchaTF mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneTF.mas_left);
            make.top.mas_equalTo(self.captchaLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(captchaTFWidth, telLableHeight));
            
        }];
        self.captchaTF.placeholder = @"请输入验证码";
        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
        self.captchaTF.font = Font14;
        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.captchaTF.borderStyle = TFborderStyle;
        
        
        self.captchaButton = [[UIButton alloc] init];
        [self.view addSubview:self.captchaButton];
        [self.captchaButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.captchaTF.mas_left).with.offset(captchaTFWidth);
            make.top.mas_equalTo(self.captchaTF.mas_top);
            make.size.mas_equalTo(CGSizeMake(captchaTFWidth, telLableHeight));
            
        }];
        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.captchaButton setTintColor:buttonTitleC];
        self.captchaButton.backgroundColor = buttonBG;
        self.captchaButton.layer.cornerRadius = BtncornerRadius;
        self.captchaButton.titleLabel.font = Font16;
        
        
        
        // 新密码
        CGFloat pwdY = telLableHeight + Kver;
//        self.pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, pwdY, telLableWidth, telLableHeight)];
        self.pwdLabel = [[UILabel alloc] init];
        [self.view addSubview:self.pwdLabel];
        [self.pwdLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
           
            make.left.mas_equalTo(self.telphoneLabel.mas_left);
            make.top.mas_equalTo(self.captchaLabel.mas_top).with.offset(pwdY);
            make.size.mas_equalTo(CGSizeMake(telLableWidth, telLableHeight));
            
        }];
        self.pwdLabel.text = @"新密码";
        self.pwdLabel.font = Font16;
        
        // 输入新密码
//        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdY, telWidth, telLableHeight)];
        self.pwdTF = [[UITextField alloc] init];
        [self.view addSubview:self.pwdTF];
        [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneTF.mas_left);
            make.top.mas_equalTo(self.pwdLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(telWidth, telLableHeight));
            
        }];
        self.pwdTF.placeholder = @"请输入新密码";
                self.pwdTF.secureTextEntry =YES;
        self.pwdTF.secureTextEntry = YES;
        self.pwdTF.font = Font14;
        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;

        self.pwdTF.borderStyle = TFborderStyle;
        
        
        
        
        // 确认密码
        CGFloat okPwdY = telLableHeight + Kver;
//        self.okPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, okPwdY, telLableWidth, telLableHeight)];
        self.okPwdLabel = [[UILabel alloc] init];
        [self.view addSubview:self.okPwdLabel];
        [self.okPwdLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneLabel.mas_left);
            make.top.mas_equalTo(self.pwdLabel.mas_top).with.offset(okPwdY);
            make.size.mas_equalTo(CGSizeMake(telLableWidth, telLableHeight));
            
        }];
        self.okPwdLabel.text = @"确认密码";
        self.okPwdLabel.font = Font16;
        
        // 请确认输入的密码
//        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdY, telWidth, telLableHeight)];
        self.okPwdTF = [[UITextField alloc] init];
        [self.view addSubview:self.okPwdTF];
        [self.okPwdTF mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.left.mas_equalTo(self.telphoneTF.mas_left);
            make.top.mas_equalTo(self.okPwdLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(telWidth, telLableHeight));
            
        }];
        self.okPwdTF.placeholder = @"请确认密码";
        self.okPwdTF.secureTextEntry = YES;
        self.okPwdTF.font = Font14;
        self.okPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.okPwdTF.borderStyle = TFborderStyle;
        
        
                                                                                     
        // 找回密码
        CGFloat findPwdX = (KScreenWidth / 2) - 60;
        CGFloat findPwdY = telLableHeight + 40;
//        CGFloat findPwdY = 300;
        CGFloat findPwdWidth = 120;
        CGFloat findPwdHeight = 30;
        self.findPwdButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.findPwdButton setTintColor:buttonTitleC];
        self.findPwdButton.backgroundColor = buttonBG;
        self.findPwdButton.layer.cornerRadius = BtncornerRadius;
//        self.findPwdButton.frame = CGRectMake(findPwdX, findPwdY, findPwdWidth, telLableHeight);
        [self.view addSubview:self.findPwdButton];
        [self.findPwdButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
           
            make.left.mas_equalTo(findPwdX);
            make.top.mas_equalTo(self.okPwdLabel.mas_top).with.offset(findPwdY);
            make.size.mas_equalTo(CGSizeMake(findPwdWidth, findPwdHeight));
            
        }];
        [self.findPwdButton setTitle:@"点击找回密码" forState:(UIControlStateNormal)];
        [self.findPwdButton addTarget:self action:@selector(findPwdAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    
    return self;
}

/** 发送验证码点击按钮 */
-(void)captchaAction
{
    //判断手机号输入是否正确
    if (![self.telphoneTF.text isMobileNumber])
    {
//        [self addAlertMessage:@"手机号输入有误，请核对！" title:@"提示"];
        return;
    }
    
    //判断验证码是否可用，第一次进入时调用
    if (!self.selectedBTN)
    {
//        [self getNumbers:self.telphoneTF.text];
    }
    
    __block int timeout=30; //倒计时时间
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
            int seconds = timeout % 30;
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







- (void)findPwdAction
{
    
    [self.view endEditing:YES];
    //    //核对输入参数
    
    
    //总体
//    NSInteger count  = self.fields.count;
//    for (int i =0; i < count ; i++)
//    {
//        UITextField * field= self.fields[i];
//        if (field.text.length ==0 || field.text ==nil)
//        {
//            [self addAlertMessage:@"信息不全，请核对！" title:@"提示"];
//            return;
//        }}
    
    //电话号
    if ( ![self.telphoneTF.text isMobileNumber])
    {
//        [self addAlertMessage:@"手机号输入有误，请核对!" title:@"提示"];
        return;
    }
    //密码
    if (! (self.pwdTF.text.length >5 && self.pwdTF.text.length <33) )
    {
        
//        [self addAlertMessage:@"密码输入错误，请输入6-32位密码！" title:@"提示"];
        return;
    }
    
    //确认密码
    if (! [self.okPwdTF.text isEqualToString:self.pwdTF.text] )
    {
        
//        [self addAlertMessage:@"密码输入不一致，请核对！" title:@"提示"];
        return;
    }
    
    //验证码
    if (!(self.captchaTF.text.length == 6))
    {
//        [self addAlertMessage:@"验证码输入有误，请核对！" title:@"提示"];
        return;
    }
    
    /*
     忘记密码
     地    址:	http://192.168.10.114:8080/yysj/userservlet?movtion=5
     需要参数:	String username 用户名 (必填)
     String password 密码 (必填)
     String repassword 确认密码 (必填)
     String checkCode 验证码
     请求方式	POST
     执行操作:	当前用户忘记密码时，通过这个接口进行更改密码。
     返回结果:	Int resultCode  1000表示成功
     Int resultCode  1006 表示参数中有null
     Int resultCode  1007表示没有登录
     Int resultCode  1021  表示用户名不存在
     */
    
    UserInfo *userIn = [UserInfo sharedUserInfo];
    
    NSString *password = [RSA encryptString:self.pwdTF.text publicKey:userIn.publicKey];
    
    //拼接注册参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = self.telphoneTF.text;
    params[@"value"] = password;
    params[@"checkCode"] = self.captchaTF.text;
    
    YYLog(@"params----%@",params);
    
    //设置遮盖
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"%@userservlet?movtion=5",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"%@找回密码返回==========",responseObject);
         //1.移除遮盖
         [SVProgressHUD setMinimumDismissTimeInterval:3];
         
         NSNumber *resultCode = responseObject[@"resultCode"];
         int result = [resultCode intValue];
         
         [self checkFindPwdResult:result];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"找回密码失败失败----%@",error);
         // 显示失败信息
         [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
     }];
}


-(void)checkFindPwdResult:(int)result
{
    switch (result)
    {
        case 1000:
        {
            [SVProgressHUD showSuccessWithStatus:@"找回成功！"];
            break;
        }
        case 1020:
        {
            [SVProgressHUD showErrorWithStatus:@"修改密码失败！"];
            break;
        }
        case 1021:
        {
            [SVProgressHUD showErrorWithStatus:@"用户名不存在！"];
            break;
        }
        case 1008:
        {
            [SVProgressHUD showErrorWithStatus:@"验证码错误！"];
            break;
        }
            
        default:
            break;
    }
}



@end

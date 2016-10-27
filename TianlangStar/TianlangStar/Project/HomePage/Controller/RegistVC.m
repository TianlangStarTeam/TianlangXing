//
//  RegistVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()

@end

@implementation RegistVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}



- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        // 背景图片
        self.pictureView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.pictureView.image = [UIImage imageNamed:@"Background"];
        self.pictureView.userInteractionEnabled = YES;
        [self.view addSubview:self.pictureView];
        
        
        
        // 手机号
        CGFloat telLableX = 0.1 * KScreenWidth;
        CGFloat telLableY = 100;
        CGFloat telLableWidth = 80;
        CGFloat telLableHeight = 30;
        self.telphoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, telLableY, telLableWidth, telLableHeight)];
        self.telphoneLabel.text = @"手机号";
        self.telphoneLabel.font = Font16;
        [self.pictureView addSubview:self.telphoneLabel];
        
        
        
        // 输入手机号
        CGFloat telX = telLableX + telLableWidth + Klength10;
        CGFloat telWidth = KScreenWidth - telLableX - Klength10 - telLableWidth - Klength5;
        self.telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, telLableY, telWidth, telLableHeight)];
        self.telphoneTF.font = Font12;
        self.telphoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.telphoneTF.borderStyle = TFborderStyle;
        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.telphoneTF.placeholder = @"请输入手机号";
        self.telphoneTF.keyboardType = UIKeyboardTypeNumberPad;
        [self.pictureView addSubview:self.telphoneTF];
        
        
        
        // 密码
        CGFloat pwdLableY = telLableY +telLableHeight + Klength15;
        self.pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, pwdLableY, telLableWidth, telLableHeight)];
        self.pwdLabel.text = @"密码";
        self.pwdLabel.font = Font16;
        [self.pictureView addSubview:self.pwdLabel];
        
        // 输入密码
        self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, pwdLableY, telWidth, telLableHeight)];
        self.pwdTF.placeholder = @"请输入密码";
        self.pwdTF.secureTextEntry = YES;
        self.pwdTF.font = Font12;
        self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.pwdTF.borderStyle = TFborderStyle;
        self.pwdTF.secureTextEntry = YES;
        [self.pictureView addSubview:self.pwdTF];
        
        
        
        // 确认密码
        CGFloat okPwdLabelY = pwdLableY + telLableHeight + Klength15;
        self.okPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, okPwdLabelY, telLableWidth, telLableHeight)];
        self.okPwdLabel.text = @"确认密码";
        self.okPwdLabel.font = Font16;
        [self.pictureView addSubview:self.okPwdLabel];
        
        // 确认输入的密码
        self.okPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, okPwdLabelY, telWidth, telLableHeight)];
        self.okPwdTF.placeholder = @"请确认密码";
        self.okPwdTF.secureTextEntry = YES;
        self.okPwdTF.font = Font12;
        self.okPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.okPwdTF.borderStyle = TFborderStyle;
        self.okPwdTF.secureTextEntry = YES;
        [self.pictureView addSubview:self.okPwdTF];
        
        
        
        // 验证码
        CGFloat captchaLabelY = okPwdLabelY + telLableHeight + Klength15;
        self.captchaLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, captchaLabelY, telLableWidth, telLableHeight)];
        //        self.captchaLabel.hidden = YES;
        self.captchaLabel.text = @"验证码";
        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
        self.captchaLabel.font = Font16;
        [self.pictureView addSubview:self.captchaLabel];
        
        // 输入验证码
        CGFloat captchaWidth = 0.55 * telWidth;
        self.captchaTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, captchaLabelY, captchaWidth, telLableHeight)];
        //        self.captchaTF.hidden = YES;
        self.captchaTF.placeholder = @"请输入验证码";
        self.captchaTF.keyboardType = UIKeyboardTypeNumberPad;
        self.captchaTF.font = Font12;
        self.captchaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.captchaTF.borderStyle = TFborderStyle;
        [self.pictureView addSubview:self.captchaTF];
        
        // 点击获取验证码
        CGFloat captchaButtonX = telX + captchaWidth;
        CGFloat captchaButtonWidth = 0.45 * telWidth;
        self.captchaButton = [[UIButton alloc] init];
        self.captchaButton.frame = CGRectMake(captchaButtonX, captchaLabelY, captchaButtonWidth, telLableHeight);
        [self.captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [self.captchaButton addTarget:self action:@selector(captchaAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.captchaButton.backgroundColor = buttonBG;
        self.captchaButton.layer.cornerRadius = BtncornerRadius;
        [self.captchaButton setTintColor:buttonTitleC];
        self.captchaButton.titleLabel.font = Font14;
        [self.pictureView addSubview:self.captchaButton];
        
        
        
        // 推荐人
        CGFloat referrerLabelY = captchaLabelY + telLableHeight + Klength15;
        self.referrerLabel = [[UILabel alloc] initWithFrame:CGRectMake(telLableX, referrerLabelY, telLableWidth, telLableHeight)];
        self.referrerLabel.text = @"推荐人";
        self.referrerLabel.font = Font16;
        [self.pictureView addSubview:self.referrerLabel];
        
        // 输入推荐人号码
        CGFloat referrerTFY = captchaLabelY + telLableHeight + Klength10;
        self.referrerTF = [[UITextField alloc] initWithFrame:CGRectMake(telX, referrerTFY, telWidth, telLableHeight)];
        self.referrerTF.placeholder = @"请输入推荐人电话号码";
        self.referrerTF.keyboardType = UIKeyboardTypeNumberPad;
        self.referrerTF.font = Font12;
        self.referrerTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.referrerTF.borderStyle = TFborderStyle;
        [self.pictureView addSubview:self.referrerTF];
        
        
        
        // 确定
        CGFloat okX = (KScreenWidth / 2) - 40;
        CGFloat okY = referrerLabelY + telLableHeight + Klength20;
        CGFloat okWidth = KScreenWidth *0.4;
        CGFloat okHeight = 30;
        self.okButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.okButton.frame = CGRectMake(okX, okY, okWidth, okHeight);
        self.okButton.centerX = KScreenWidth * 0.5;
        [self.okButton setTitle:@"确定" forState:
         (UIControlStateNormal)];
        self.okButton.backgroundColor = buttonBG;
        [self.okButton setTintColor:buttonTitleC];
        self.okButton.layer.cornerRadius = BtncornerRadius;
        [self.okButton addTarget:self action:@selector(okRegistAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.pictureView addSubview:self.okButton];
        
    }
    
    return self;
}



/** 事件:获取验证码 */
- (void)captchaAction
{
}



/** 事件:确定注册 */
- (void)okRegistAction
{
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

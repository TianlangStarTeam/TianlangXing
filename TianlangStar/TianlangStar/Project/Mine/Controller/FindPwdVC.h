//
//  FindPwdVC.h
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/********** 找回密码 **********/


#import <UIKit/UIKit.h>

@interface FindPwdVC :UIViewController

@property (nonatomic,strong) UIImageView *pictureView;

@property (nonatomic,strong) UILabel *telphoneLabel;
@property (nonatomic,strong) UITextField *telphoneTF;
@property (nonatomic,strong) UILabel *captchaLabel;// 验证码
@property (nonatomic,strong) UITextField *captchaTF;// 验证码
/** 验证码点击按钮 */
@property (nonatomic,strong) UIButton *captchaButton;// 点击获取验证码
@property (nonatomic,strong) UILabel *pwdLabel;
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UILabel *okPwdLabel;
@property (nonatomic,strong) UITextField *okPwdTF;
@property (nonatomic,strong) UIButton *findPwdButton;



@end

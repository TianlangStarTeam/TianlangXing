//
//  LoginVC.h
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/********** 登录 **********/


#import <UIKit/UIKit.h>




@protocol LoginVCDelegate <NSObject>

//- (void)cancleAction;
- (void)backEachElement:(NSInteger )userType;

@end

@interface LoginVC :UIViewController

@property (nonatomic,strong) UIImageView *userNamePic;
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UIImageView *pwdPic;
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UIImageView *captchaPic;// 验证码
@property (nonatomic,strong) UITextField *captchaTF;
@property (nonatomic,strong) UIButton *captchaButton;
@property (nonatomic,strong) UIButton *registButton;
@property (nonatomic,strong) UIButton *foundPwdButton;
@property (nonatomic,strong) UIButton *okButton;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,weak) id<LoginVCDelegate> delegate;

@end

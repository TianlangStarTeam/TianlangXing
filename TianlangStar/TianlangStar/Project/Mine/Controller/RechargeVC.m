//
//  RechargeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/10.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "RechargeVC.h"

@interface RechargeVC ()


/** 手机号的输入框 */
@property (nonatomic,weak) UITextField *phoneText;

@end

@implementation RechargeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];

}


-(void)setupView
{
    
    CGFloat left = 20;
    CGFloat top = 80;
    CGFloat margin = 10;
    
    //手机号
    UILabel *phone = [[UILabel alloc] init];
    phone.text  = @"手机号";
    phone.x = left;
    phone.y = top;
    phone.width = 80;
    phone.height = 40;
    
    [self.view addSubview:phone];
    
    
    UIButton *checkBtn = [[UIButton alloc] init];
    checkBtn.width = 60;
    checkBtn.height = 30;
    checkBtn.centerY = phone.centerY;
    checkBtn.backgroundColor = [UIColor blueColor];
    checkBtn.layer.masksToBounds = YES ;
    checkBtn.layer.cornerRadius = 5;
    checkBtn.x = KScreenWidth - checkBtn.width - margin;
    [checkBtn setTitle:@"检查" forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    
    UITextField *phoneText = [[UITextField alloc] init];
    phoneText.x = CGRectGetMaxX(phone.frame) + margin;
    phoneText.width = KScreenWidth - phoneText.x - checkBtn.width - 2 *margin;
    phoneText.height = 40;
    
    phoneText.centerY = phone.centerY;
    phoneText.placeholder = @"请输入手机号";
    self.phoneText = phoneText;
    [self.view addSubview:phoneText];
    

}

//检查按钮的点击事件
-(void)checkBtnClick
{
    YYLog(@"检查");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

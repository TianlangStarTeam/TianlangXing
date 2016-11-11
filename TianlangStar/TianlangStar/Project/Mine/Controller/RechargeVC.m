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

/** 充值时查询到的用户名 */
@property (nonatomic,weak) UILabel *username;


/** 输入充值现金时候直接转换成星币 */
@property (nonatomic,weak) UILabel *addStar;



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
    CGFloat top = KScreenHeight * 0.14;
    CGFloat margin = 10;
    CGFloat labelH = 30;
    
    //手机号
    UILabel *phone = [[UILabel alloc] init];
    phone.text  = @"手机号";
    phone.x = left;
    phone.y = top;
    phone.width = 54;
    phone.height = labelH;
    phone.font = Font16;
//    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:phone];
    
    
    UIButton *checkBtn = [[UIButton alloc] init];
    checkBtn.width = 60;
    checkBtn.height = labelH;
    checkBtn.centerY = phone.centerY;
    checkBtn.backgroundColor = [UIColor blueColor];
    checkBtn.layer.masksToBounds = YES ;
    checkBtn.layer.cornerRadius = BtncornerRadius;
    checkBtn.titleLabel.font = Font14;
    checkBtn.x = KScreenWidth - checkBtn.width - margin;
    [checkBtn setTitle:@"检查" forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    //手机号输入框
    UITextField *phoneText = [[UITextField alloc] init];
    phoneText.x = CGRectGetMaxX(phone.frame) + margin;
    phoneText.width = KScreenWidth - phoneText.x - checkBtn.width - 2 *margin;
    phoneText.height = labelH;
    
    phoneText.centerY = phone.centerY;
    phoneText.borderStyle = TFborderStyle;
    phoneText.placeholder = @"请输入手机号";
    self.phoneText = phoneText;
    [self.view addSubview:phoneText];
    
    //用户名
    UILabel *user = [[UILabel alloc] init];
    user.x = left;
    user.y = CGRectGetMaxY(phone.frame) + 20;
    user.width = 55;
    user.height  = labelH;
    user.font = Font16;
    user.text = @"用户名";
    [self.view addSubview:user];
    
    
    //查询到的用户名
    //用户名
    UILabel *username = [[UILabel alloc] init];
    username.x = CGRectGetMaxX(user.frame) + 20;
    username.width = 156;
    username.height  = labelH;
    username.centerY = user.centerY;
//    username.text = @"用户名";
    username.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:username];
    
    
    //账户余额和历史记录
    
    UIButton *balanceBtn = [[UIButton alloc] init];
    balanceBtn.width = 100;
    balanceBtn.height = labelH;
    balanceBtn.y = CGRectGetMaxY(user.frame) + 30;
    balanceBtn.backgroundColor = [UIColor blueColor];
    balanceBtn.layer.masksToBounds = YES ;
    balanceBtn.layer.cornerRadius = BtncornerRadius;
    balanceBtn.titleLabel.font = Font14;
    balanceBtn.x = left + 15;
    [balanceBtn setTitle:@"账户余额" forState:UIControlStateNormal];
    [balanceBtn addTarget:self action:@selector(balanceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balanceBtn];
    
    UIButton *recordsBtn = [[UIButton alloc] init];
    recordsBtn.width = balanceBtn.width;
    recordsBtn.height = balanceBtn.height;
    recordsBtn.y = balanceBtn.y;
    recordsBtn.backgroundColor = [UIColor blueColor];
    recordsBtn.titleLabel.font = Font14;
    recordsBtn.layer.masksToBounds = YES ;
    recordsBtn.layer.cornerRadius = BtncornerRadius;
    recordsBtn.x = KScreenWidth - CGRectGetMaxX(balanceBtn.frame);
    [recordsBtn setTitle:@"历史记录" forState:UIControlStateNormal];
    [recordsBtn addTarget:self action:@selector(recordsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordsBtn];
    
    //账户余额和充值金额
    UILabel *balanceLB = [[UILabel alloc] init];
    balanceLB.text  = @"账户余额";
    balanceLB.x = left;
    balanceLB.y = CGRectGetMaxY(balanceBtn.frame) + 20;
    balanceLB.width = 75;
    balanceLB.height = labelH;
    balanceLB.font = Font16;
    //    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:balanceLB];
    
    UILabel *rechargeLB = [[UILabel alloc] init];
    rechargeLB.text  = @"充值金额";
    rechargeLB.x = left;
    rechargeLB.y = CGRectGetMaxY(balanceLB.frame) + 10;
    rechargeLB.width = 75;
    rechargeLB.height = labelH;
    rechargeLB.font = Font16;
    
    [self.view addSubview:rechargeLB];
    
    
    //账户余额和充值金额
    UILabel *creditLB = [[UILabel alloc] init];
    creditLB.text  = @"现金";
    creditLB.x = left + 15;
    creditLB.y = CGRectGetMaxY(rechargeLB.frame) + 20;
    creditLB.width = 50;
    creditLB.height = labelH;
    creditLB.font = Font16;
    //    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:creditLB];
    
    
    //冲值金额的输入框
    UITextField *moneyTF = [[UITextField alloc] init];
    moneyTF.x = CGRectGetMaxX(phone.frame) + margin;
    moneyTF.width = KScreenWidth * 0.5 - CGRectGetMaxX(creditLB.frame) -20;
    moneyTF.height = labelH;
    moneyTF.centerY = creditLB.centerY;
    moneyTF.borderStyle = TFborderStyle;
    moneyTF.placeholder = @"请输入金额";
    moneyTF.font = Font14;
//    moneyTF.backgroundColor = [UIColor redColor];
    self.phoneText = phoneText;
    [self.view addSubview:moneyTF];
    
    
    //星币
    UILabel *star = [[UILabel alloc] init];
    star.text  = @"星币";
    star.x = KScreenWidth * 0.5 + 10;
    star.y = creditLB.y;
    star.width = 50;
    star.height = labelH;
    star.font = Font16;
    star.backgroundColor = [UIColor redColor];
    [self.view addSubview:star];
    
    
    UILabel *addStar = [[UILabel alloc] init];
    addStar.text  = @"1000";
    addStar.x = CGRectGetMaxX(star.frame);
    addStar.y = creditLB.y;
    addStar.width = 100;
    addStar.height = labelH;
    addStar.font = Font16;
    self.addStar = addStar;
    //    phone.backgroundColor = [UIColor redColor];
    [self.view addSubview:addStar];
    
    
    
    //底部的确认充值按钮
    UIButton *OKBtn = [[UIButton alloc] init];
    OKBtn.width = KScreenWidth;
    OKBtn.height = 55;
    OKBtn.y = KScreenHeight - OKBtn.height;
    OKBtn.x = 0;
    OKBtn.backgroundColor = [UIColor blueColor];
    OKBtn.titleLabel.font = Font18;
//    OKBtn.layer.masksToBounds = YES;
//    OKBtn.layer.cornerRadius = BtncornerRadius;
    [OKBtn setTitle:@"确认充值" forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(OKBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OKBtn];
    
    
}

//检查按钮的点击事件
-(void)checkBtnClick
{
    YYLog(@"检查");
}

/* 余额按钮的点击事件 */
-(void)balanceBtnClick
{

    YYLog(@"余额查询");

}

/* 历史记录按钮的点击事件 */
-(void)recordsBtnClick
{
  YYLog(@"历史记录");

}


/* 确认充值按钮的点击事件 */
-(void)OKBtnClick
{
    YYLog(@"确认充值");
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

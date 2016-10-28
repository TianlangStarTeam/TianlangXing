//
//  MineVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"
#import "FindPwdVC.h"

@interface MineVC ()



@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 90, 30)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *findBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 90, 30)];
    [findBtn addTarget:self action:@selector(findBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [findBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.view addSubview:findBtn];

}

/**
 *  登录
 */
-(void)buttonClick
{
    LoginVC *vc = [[LoginVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    NSLog(@"fuowqugoqugoq3");
}

-(void)findBtnClick
{
    FindPwdVC *vc = [[FindPwdVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    NSLog(@"忘记密码");
}



@end

//
//  HomePageVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageVC.h"

#import "RegistVC.h"

@interface HomePageVC ()

/** 注册按钮 */
@property (nonatomic,strong) UIButton *registButton;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册按钮
    self.registButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registButton.frame = CGRectMake(30, 200, 80, 44);
    [self.registButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.registButton addTarget:self action:@selector(actionRegist) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.registButton];
    
}



/**
 *  时间:注册的点击事件
 */
- (void)actionRegist
{
    RegistVC *registVC = [[RegistVC alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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
























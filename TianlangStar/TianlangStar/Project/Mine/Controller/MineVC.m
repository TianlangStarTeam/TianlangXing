//
//  MineVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"

@interface MineVC ()



@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 90, 30)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];

}

-(void)buttonClick
{
    
    LoginVC *vc = [[LoginVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"fuowqugoqugoq3");
}



@end

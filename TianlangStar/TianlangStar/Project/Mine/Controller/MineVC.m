//
//  MineVC.m
//  TianlangStar
//
//  Created by Beibei on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"
#import "ForgetPwdVC.h"
#import "LoginView.h"


@interface MineVC ()



@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    LoginView *logView = [[LoginView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:logView];

}





@end

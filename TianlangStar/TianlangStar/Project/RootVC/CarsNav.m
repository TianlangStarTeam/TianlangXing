//
//  CarsNav.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarsNav.h"

@interface CarsNav ()

@end

@implementation CarsNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    

    if (self.viewControllers.count > 0)
    {
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    

    [super pushViewController:viewController animated:animated];
}





@end

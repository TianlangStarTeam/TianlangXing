//
//  ResetPasword.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/5.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ResetPasword.h"

@interface ResetPasword ()

@end

@implementation ResetPasword

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupResetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupResetView
{
    NSString *str = @"qqq111";
    NSString *psw = [RSA encryptString:str publicKey:[UserInfo sharedUserInfo].publicKey];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"id"] = [UserInfo sharedUserInfo].userID;
    parmas[@"value"] = psw;
    
    
    NSString * url = [NSString stringWithFormat:@"%@resetvalueservlet",URL];
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"重置密码--json---%@",json);
        
    } failure:^(NSError *error)
    {
         YYLog(@"重置密码--error---%@",error);
        
    }];
    

}


@end

//
//  AccountTVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//  账户管理管理员修改别人的信息  只能改手机号 和会员级别  别的一律不动

#import <UIKit/UIKit.h>
@class UserModel;

@interface AccountMTVC : UITableViewController

/** 传入的用户模型数据 */
@property (nonatomic,strong) UserModel *userModel;

@end

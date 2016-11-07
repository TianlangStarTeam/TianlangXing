//
//  CarInfoChangeVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//  车辆信息修改

#import <UIKit/UIKit.h>
#import "CarModel.h"

@interface CarInfoChangeVC : UITableViewController


/** 传入的Cars模型 */
@property (nonatomic,strong) CarModel *carInfo;

@end

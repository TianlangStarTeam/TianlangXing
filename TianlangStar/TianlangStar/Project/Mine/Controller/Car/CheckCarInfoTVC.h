//
//  CheckCarInfoTVC.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;


@interface CheckCarInfoTVC : UITableViewController

/** 传入的车辆模型 */
@property (nonatomic,strong) CarModel *carModel;


@end

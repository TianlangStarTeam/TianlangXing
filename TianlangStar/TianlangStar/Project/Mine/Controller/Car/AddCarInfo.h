//
//  AddCarInfo.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/4.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    carid = 0,
    brand,
    model,
    cartype,
    frameid,
    engineid,
    buytime,
    insuranceid,
    insurancetime,
    commercialtime
} CheckinCar;

@interface AddCarInfo : UITableViewController

@end

//
//  AddCarTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/15.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    cartype = 0,
    brand,
    model,
    carid,
    buytime,
    frameid,
    engineid
} CarInfoType;


@interface AddCarTableVC : UITableViewController

@property (nonatomic,assign) NSInteger userid;

@end

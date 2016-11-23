//
//  ProductPublishTableVC.h
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 商品入库 */
typedef enum : NSUInteger {
    productname = 0,
    productmodel,
    specifications,
    applycar,
    vendors,
    inventory,
    purchaseprice,
    price,
    scoreprice,
    introduction,
    remark
} ProductPublish;

/** 服务入库 */
typedef enum : NSUInteger {
    services = 0,
    servicetype,
    content,
    warranty,
    manhours,
    servicePrice,
    serviceScoreprice
} ServicePublish;

/** 二手车入库 */
typedef enum : NSUInteger {
    brand = 0,
    carPrice,
    model,
    cartype,
    mileage,
    buytime,
    number,
    person,
    frameid,
    engineid,
    property,
    carDescription
} SecondCarPublish;

@interface ProductPublishTableVC : UITableViewController

@end












































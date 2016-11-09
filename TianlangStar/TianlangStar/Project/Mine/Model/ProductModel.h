//
//  ProductModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//   商品和服务模型 -- 公用

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

/** 积分价格 */
@property (nonatomic,assign) NSInteger scoreprice;

/** 商品的ID */
@property (nonatomic,copy) NSString *ID;

/** 商品的名称 */
@property (nonatomic,copy) NSString *productname;

/** 商品的名称 */
@property (nonatomic,assign) NSInteger inventory;

/** 商品的图片地址 */
@property (nonatomic,copy) NSString *images;

/** 商品的价格 */
@property (nonatomic,assign) NSInteger price;

/** 服务 */
@property (nonatomic,copy) NSString *services;




@end
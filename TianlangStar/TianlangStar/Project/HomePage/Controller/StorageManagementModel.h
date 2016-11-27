//
//  StorageManagementModel.h
//  TianlangStar
//
//  Created by Beibei on 16/11/25.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManagementModel : NSObject

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,copy) NSString *productname;

@property (nonatomic,assign) NSInteger inventory;

@property (nonatomic,copy) NSString *saleState;

@property (nonatomic,assign,getter=isSelected) BOOL selectedBtn;

@end

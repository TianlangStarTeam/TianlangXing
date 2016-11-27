//
//  StorageManagementCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StorageManagementModel;
@interface StorageManagementCell : UITableViewCell

@property (nonatomic,strong) UIButton *selectButtton;// 复选框

@property (nonatomic,strong) UILabel *nameLabel;// 名称

@property (nonatomic,strong) UILabel *countLabel;// 库存

@property (nonatomic,strong) UILabel *statusLabel;// 状态

@property (nonatomic,strong) StorageManagementModel *storageManagementModel;

@end

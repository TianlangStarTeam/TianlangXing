//
//  HomePageSelectCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "HomePageSelectCell.h"

@implementation HomePageSelectCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGFloat buttonWidth = KScreenWidth / 3;
        
        self.maintenanceButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.maintenanceButton.frame = CGRectMake(0, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.maintenanceButton];
        
        
        
        self.productButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.productButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.productButton];
        
        
        
        self.carInfoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.carInfoButton.frame = CGRectMake(2 * buttonWidth, 0, buttonWidth, Klength44);
        [self.contentView addSubview:self.carInfoButton];
        
        
        
        [self.maintenanceButton setTitle:@"保养维护" forState:(UIControlStateNormal)];
        [self.maintenanceButton addTarget:self action:@selector(maintenanceAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.productButton setTitle:@"商品" forState:(UIControlStateNormal)];
        [self.productButton addTarget:self action:@selector(productAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        [self.carInfoButton setTitle:@"车辆信息" forState:(UIControlStateNormal)];
        [self.carInfoButton addTarget:self action:@selector(carInfoAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

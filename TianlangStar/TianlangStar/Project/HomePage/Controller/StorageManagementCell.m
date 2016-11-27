//
//  StorageManagementCell.m
//  TianlangStar
//
//  Created by Beibei on 16/11/24.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementCell.h"

#import "StorageManagementModel.h"

@implementation StorageManagementCell



- (void)setStorageManagementModel:(StorageManagementModel *)storageManagementModel
{
    _storageManagementModel = storageManagementModel;
    
    _selectButtton.selected = storageManagementModel.selectedBtn;
    _nameLabel.text = storageManagementModel.productname;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        CGFloat top = 10;
        
        CGFloat height = 70;
        CGFloat labelHeight = 50;
        
        CGFloat selectButtonX = 21;
        CGFloat selectButtonwidth = 22;
        CGFloat selectButttonY = (height / 2) - (selectButtonwidth / 2);
        self.selectButtton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        self.selectButtton.backgroundColor = [UIColor redColor];
        self.selectButtton.frame = CGRectMake(selectButtonX, selectButttonY, selectButtonwidth, selectButtonwidth);
        [self.selectButtton setImage:[[UIImage imageNamed:@"unselected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [self.selectButtton setImage:[[UIImage imageNamed:@"selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
        [self.contentView addSubview:self.selectButtton];
        
        
        CGFloat width = (KScreenWidth - selectButtonX - selectButtonwidth - 30 - 2 * 20 - 15);
        
        CGFloat nameLabelX = selectButtonX + selectButtonwidth + 30;
        CGFloat nameLabelWidth = 0.5 * width;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, top, nameLabelWidth, labelHeight)];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = Font12;
        [self.contentView addSubview:self.nameLabel];
        
        
        
        CGFloat countLabelX = nameLabelX + nameLabelWidth + 20;
        CGFloat countLabelWidth = 0.2 * width;
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countLabelX, top, countLabelWidth, labelHeight)];
        self.countLabel.font = Font12;
        [self.contentView addSubview:self.countLabel];
        
        
        
        CGFloat statusLabelX = countLabelX + countLabelWidth + 20;
        CGFloat statusLabelWidth = 0.3 * width;
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabelX, top, statusLabelWidth, labelHeight)];
        self.statusLabel.font = Font12;
        [self.contentView addSubview:self.statusLabel];
        
        
//        self.nameLabel.backgroundColor = [UIColor redColor];
//        self.countLabel.backgroundColor = [UIColor cyanColor];
//        self.statusLabel.backgroundColor = [UIColor orangeColor];
        
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

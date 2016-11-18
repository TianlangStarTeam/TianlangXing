//
//  ProductPublishTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/18.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ProductPublishTableVC.h"

#import "LabelTextFieldCell.h"
#import "LabelTFLabelCell.h"

@interface ProductPublishTableVC ()

@property (nonatomic,strong) NSArray *leftBaseLabelArray;

@property (nonatomic,strong) NSArray *saleLabelArray;

@property (nonatomic,strong) NSArray *introduceLabelArray;

@end

@implementation ProductPublishTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftBaseLabelArray = @[@"商品名称",@"商品类型",@"商品规格",@"适用车型",@"供应商",@"入库时间",@"入库数量",@"进价(元)"];
    _saleLabelArray = @[@"售价",@"积分"];
    _introduceLabelArray = @[@"简介",@"备注"];
    
    [self rightItem];
}



- (void)rightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"入库" style:(UIBarButtonItemStylePlain) target:self action:@selector(putinStorage)];
}



- (void)putinStorage
{
    
}



- (void)creatAddPictureView
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _leftBaseLabelArray.count;
    }
    else if (section == 1)
    {
        return _saleLabelArray.count;
    }
    else
    {
        return _introduceLabelArray.count;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        return 110;
    }
    return 40;
}



#pragma mark - 返回基本信息cell
- (LabelTextFieldCell *)tableView:(UITableView *)tableView baseInfoCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier0 = @"cell0";
    
    LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier0];
        
    }
    
    cell.leftLabel.text = _leftBaseLabelArray[indexPath.row];
    
    return cell;
}



#pragma mark - 返回售价cell
- (LabelTFLabelCell *)tableView:(UITableView *)tableView salePriceCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"cell1";
    
    LabelTFLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        cell = [[LabelTFLabelCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        
    }
    
    NSArray *array = @[@"星币",@"积分"];
    cell.salePriceLabel.text = _saleLabelArray[indexPath.row];
    cell.priceLabel.text = array[indexPath.row];
    
    return cell;
}



#pragma mark - 返回简介备注cell
- (LabelTextFieldCell *)tableView:(UITableView *)tableView IntroduceCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier2 = @"cell2";
    
    LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
        
    }
    
    cell.rightTF.height = 100;
    cell.leftLabel.text = _introduceLabelArray[indexPath.row];
    
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [self tableView:tableView baseInfoCellWithIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        return [self tableView:tableView salePriceCellWithIndexPath:indexPath];
    }
    else
    {
        return [self tableView:tableView IntroduceCellWithIndexPath:indexPath];
    }
}








@end



















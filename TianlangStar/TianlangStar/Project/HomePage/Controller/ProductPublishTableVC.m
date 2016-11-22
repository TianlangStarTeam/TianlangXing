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
#import "AddImagesCollectionVC.h"
#import "AddImages.h"

@interface ProductPublishTableVC ()

@property (nonatomic,strong) NSArray *leftBaseLabelArray;

@property (nonatomic,strong) NSArray *leftSeviceLabelArray;

@property (nonatomic,strong) NSArray *leftSecondcarLabelArray;

@property (nonatomic,strong) UISegmentedControl *segment;

@end

@implementation ProductPublishTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftBaseLabelArray = @[@"商品名称",@"商品类型",@"商品规格",@"适用车型",@"供应商",@"入库时间",@"入库数量",@"进价(元)",@"售价",@"积分",@"简介",@"备注"];
    
    _leftSeviceLabelArray = @[@"服务项目",@"服务类型",@"服务内容",@"保修期限",@"预计耗时",@"售价",@"积分"];
    
    _leftSecondcarLabelArray = @[@"品牌",@"报价",@"型号",@"车型",@"行驶里程",@"购买年份",@"车牌号",@"原车主",@"车架号",@"发动机号",@"使用性质",@"车辆简介"];
    
    [self rightItem];
    
    [self creatAddImagesView];
    
    [self creatTitleView];
}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"服务",@"二手车"]];
    self.segment.frame = CGRectMake(0, 10, 120, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segment;
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
            YYLog(@"商品");
            break;
        case 1:
            YYLog(@"服务");
            break;
        case 2:
            YYLog(@"二手车");
            break;
            
        default:
            break;
    }
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



- (void)creatAddImagesView
{
    AddImages *addImages = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.3 * KScreenHeight)];
    addImages.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = addImages;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (self.segment.selectedSegmentIndex)
    {
        case 1:
            return 2;
            break;
            
        default:
            break;
    }
    
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            return _leftBaseLabelArray.count;
            break;
        case 1:
            return _leftSeviceLabelArray.count;
            break;
        case 2:
            return _leftSecondcarLabelArray.count;
            break;
            
        default:
            break;
    }
    
    return _leftBaseLabelArray.count;
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
    
    switch (self.segment.selectedSegmentIndex) {
        case 0:
        {
            if (indexPath.row == self.leftBaseLabelArray.count - 1 || indexPath.row == self.leftBaseLabelArray.count)
            {
                cell.rightTF.height = 100;
            }
            cell.leftLabel.text = _leftBaseLabelArray[indexPath.row];
        }
            break;
        case 1:
            cell.leftLabel.text = _leftSeviceLabelArray[indexPath.row];
            break;
        case 2:
        {
            if (indexPath.row == self.leftSecondcarLabelArray.count)
            {
                cell.rightTF.height = 100;
            }
            cell.leftLabel.text = _leftSecondcarLabelArray[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    
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
//    cell.salePriceLabel.text = _saleLabelArray[indexPath.row];
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
//    cell.leftLabel.text = _introduceLabelArray[indexPath.row];
    
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



















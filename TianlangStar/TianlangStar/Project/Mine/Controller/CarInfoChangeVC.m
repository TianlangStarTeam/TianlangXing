//
//  CarInfoChangeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInfoChangeVC.h"
#import "CarInputCell.h"

@interface CarInfoChangeVC ()

/** 左侧的数组 */
@property (nonatomic,strong) NSArray *rightArr;

@end

@implementation CarInfoChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[CarInputCell class] forCellReuseIdentifier:@"cellInput"];
    
    self.title = @"车辆信息登记";
}

-(NSArray *)rightArr
{
    if (_rightArr == nil)
    {
        _rightArr = @[@"车牌号",@"品牌",@"型号",@"车型",@"车架号",@"发动机号",@"购买年份",@"保险信息",@"车牌号",@"较强险提醒日期",@"商业险提醒日期"];
    }

    return _rightArr;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rightArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarInputCell *cell = [CarInputCell cellWithTableView:tableView];
    
    NSString *name = self.rightArr[indexPath.row];
    NSString *nameInput = [NSString stringWithFormat:@"请输入%@",name];
    
    cell.textLabel.text = name;
    cell.textField.placeholder = nameInput;
    return cell;


}



@end

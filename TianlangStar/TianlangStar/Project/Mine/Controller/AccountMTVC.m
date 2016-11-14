//
//  AccountTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AccountMTVC.h"
#import "InputCell.h"

@interface AccountMTVC ()<UITextFieldDelegate>

/** 单元格的数组 */
@property (nonatomic,strong) NSArray *leftArr;

@end

@implementation AccountMTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
}

-(NSArray *)leftArr
{
    if (!_leftArr) {
        _leftArr = @[@"姓名",@"性别",@"备注",@"住址",@"级别",@"推荐人",@"手机号",@"身份证号"];
    }

    return _leftArr;
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

    return self.leftArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InputCell *cell = [InputCell cellWithTableView:tableView];
    cell.leftLB.text = self.leftArr[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.x  = 100;
    cell.textField.placeholder = @"请输入";
//    cell.textField.backgroundColor = [UIColor orangeColor];
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



#pragma mark=====textField 的代理时间的处理=====

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    YYLog(@"%@",textField.text);
}


@end

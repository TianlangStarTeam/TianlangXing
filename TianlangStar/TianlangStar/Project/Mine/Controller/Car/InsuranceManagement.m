//
//  InsuranceManagement.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "InsuranceManagement.h"
#import "InputCell.h"

@interface InsuranceManagement ()

/** 左侧的数组信息 */
@property (nonatomic,strong) NSArray *leftArr;

@end

@implementation InsuranceManagement

- (void)viewDidLoad {
    [super viewDidLoad];

}


-(NSArray *)leftArr
{
    if (!_leftArr) {
        _leftArr = @[@"保险费用",@"当年应缴",@"投保日期",@"投保单号",@"续保日期"];
    }
    return _leftArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    


    return cell;
}




@end

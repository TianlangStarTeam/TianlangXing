//
//  CarInfochangeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInfoListVC.h"
#import "CarInfoChangeVC.h"

@interface CarInfoListVC ()

@end

@implementation CarInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"车辆信息";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"      陕A  82828  宝马 320";

    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return @"名下车辆信息为:";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarInfoChangeVC *vc = [[CarInfoChangeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

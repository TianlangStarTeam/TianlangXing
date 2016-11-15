//
//  NewestActivityTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "NewestActivityTableVC.h"

@interface NewestActivityTableVC ()

@end

@implementation NewestActivityTableVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"最新活动";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.textLabel.text = @"abc";

    return cell;
}




@end

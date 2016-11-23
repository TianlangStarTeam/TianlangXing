//
//  StorageManagementTableVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "StorageManagementTableVC.h"

@interface StorageManagementTableVC ()

@property (nonatomic,strong) UISegmentedControl *segment;

@end

@implementation StorageManagementTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTitleView];// 导航栏的选择title
    
}



- (void)creatTitleView
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"未上架",@"在售",@"售罄"]];
    self.segment.frame = CGRectMake(0, 10, 120, 30);
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.apportionsSegmentWidthsByContent = YES;
    
    self.segment.selectedSegmentIndex = 1;
    self.navigationItem.titleView = self.segment;
}



- (void)segmentChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex)
    {
        case 0:
            YYLog(@"未上架");
            break;
        case 1:
            YYLog(@"在售");
            break;
        case 2:
            YYLog(@"售罄");
            break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

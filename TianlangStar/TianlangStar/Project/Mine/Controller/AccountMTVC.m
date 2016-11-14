//
//  AccountTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AccountMTVC.h"
#import "InputCell.h"
#import "UserModel.h"
#import "UserHeaderImageCell.h"


/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    membername = 0,
    sex =1,
    telephone = 2,
    identity = 3,
    address =4,
    viplevel = 5,
    referee = 6,
    description =7,
//    insurancetime = 8,
//    commercialtime = 9,
} UserInfoType;

@interface AccountMTVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 单元格的数组 */
@property (nonatomic,strong) NSArray *leftArr;

/** 用户类型的枚举 */
@property (nonatomic,assign) UserInfoType userInfoType;


/** 头像 */
@property (nonatomic,strong) UIImage *headerImg;


/** 相册的控制器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation AccountMTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"会员管理";

    YYLog(@"userModel----%@",self.userModel);
    
    [self addfooter];
}

-(NSArray *)leftArr
{
    if (!_leftArr)
    {
        _leftArr = @[@"姓名",@"性别",@"手机号",@"身份证",@"住址",@"级别",@"推荐人",@"备注"];
    }
    return _leftArr;
}

-(void)addfooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 44)];
    UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
    [button addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"➕" forState:UIControlStateNormal];
    [view addSubview:button];
    
    self.tableView.tableFooterView = view;
}

-(void)addBtnClick
{
    YYLog(@"按钮+");
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 1;
    
    switch (section)
    {
        case 0:
            count = 1;
            break;
        case 1:
            count = self.leftArr.count;;
            break;

        default:
            break;
    }

    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        UserHeaderImageCell *cell = [[UserHeaderImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.leftLable.text = @"头像";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headerPic sd_setImageWithURL:[NSURL URLWithString:self.userModel.headimage] placeholderImage:[UIImage imageNamed:@"touxiang"]];

        return cell;
        
    }else if (indexPath.section == 1)
    {
        
        InputCell *cell = [InputCell cellWithTableView:tableView];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.textField.delegate = self;
        cell.textField.x  = 100;
        cell.textField.placeholder = @"请输入";
        self.userInfoType = indexPath.row;
        cell.tag = self.userInfoType;
        
        //设置数据
        switch (self.userInfoType)
        {
            case membername://姓名
                cell.textField.text = self.userModel.membername;
                break;
            case telephone:
                cell.textField.text = self.userModel.telephone;
                break;
            case sex://性别
            {
                NSString *sexstr = nil;
                self.userModel.sex == 1 ? (sexstr = @"男") : (sexstr = @"女");
                cell.textField.text = sexstr;
                break;
            }
            case identity://身份证
                cell.textField.text = self.userModel.identity;
                break;
            case address://地址
                cell.textField.text = self.userModel.address;
                break;
            case viplevel://级别
                cell.textField.text = self.userModel.address;
                break;
            case referee://推荐人
                cell.textField.text = self.userModel.address;
                break;
            case description://备注
                cell.textField.text = self.userModel.address;
                break;
                
                
            default:
                break;
        }
        
        return cell;
    }else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return cell;
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section == 0)
    {
        return 100;
    }else
    {
    return 40;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改图像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              [self getPhotoLibraryImage];
                          }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                          YYLog(@"拍照");
                          }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                          {
                              YYLog(@"拍照");
                          }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


// 获取照相机图片
- (void)getCameraImage
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
// 获取相册图片
- (void)getPhotoLibraryImage
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}


// 从照片中获取调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.headerImg = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





#pragma mark=====textField 的代理时间的处理=====

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case membername:
            self.userModel.membername = textField.text;
            break;
        case telephone:
            self.userModel.membername = textField.text;
            break;
        case address:
            self.userModel.membername = textField.text;
            break;
        default:
            break;
    }
    YYLog(@"%@",textField.text);
}





@end

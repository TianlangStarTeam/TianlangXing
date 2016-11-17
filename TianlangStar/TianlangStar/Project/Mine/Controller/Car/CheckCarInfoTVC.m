//
//  CheckCarInfoTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/17.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CheckCarInfoTVC.h"
#import "PictureCell.h"
#import "LabelTextFieldCell.h"

/** 车辆信息录入和添加 */
typedef enum : NSUInteger {
    cartype = 0,
    brand,
    model,
    carid,
    buytime,
    frameid,
    engineid
} CarInfoType;

@interface CheckCarInfoTVC ()<UITextFieldDelegate>


/** 左边的标题栏 */
@property (nonatomic,strong) NSArray *leftLabelArray;

/** 站位数组 */
@property (nonatomic,strong) NSArray *rightPlaceholder;

/** 上传的图片 */
@property (nonatomic,strong) UIImage *carImage;

/** 枚举 */
@property (nonatomic,assign) CarInfoType carInfoType;





@end

@implementation CheckCarInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"他的爱车";
    
}



- (NSArray *)leftLabelArray
{
    if (!_leftLabelArray)
    {
        _leftLabelArray = @[@"车辆类型",@"品牌",@"型号",@"车牌号",@"购买年份",@"车架号",@"发动机号"];
    }
    
    return _leftLabelArray;
}



- (NSArray *)rightPlaceholder
{
    if (!_rightPlaceholder)
    {
        _rightPlaceholder = @[@"请输入车辆类型",@"请输入品牌",@"型号",@"请输入车牌号",@"请输入购买年份",@"请输入车架号",@"请输入发动机号码"];
    }
    
    return _rightPlaceholder;
}



- (void)finishAction
{
    [self.view endEditing:YES];
//    
//    if (self.cell.rightTF.text != nil || self.cell.rightTF.text.length != 0)
//    {
//        NSString *url = [NSString stringWithFormat:@"%@upload/carinforegistservlet",URL];
//        
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//        
//        NSString *sessionid = [UserInfo sharedUserInfo].RSAsessionId;
//        parameters[@"sessionId"] = sessionid;
//        parameters[@"userid"] = [NSString stringWithFormat:@"%ld",self.userid];
//        
//        parameters[@"cartype"] = self.carModel.cartype;
//        parameters[@"brand"] = self.carModel.brand;
//        parameters[@"model"] = self.carModel.model;
//        parameters[@"carid"] = self.carModel.carid;
//        parameters[@"buytime"] = self.carModel.buytime;
//        parameters[@"frameid"] = self.carModel.frameid;
//        parameters[@"engineid"] = self.carModel.engineid;
//        
//        YYLog(@"添加爱车的参数%@",parameters);
//        
//        if (self.carModel.cartype == nil || self.carModel.brand == nil || self.carModel.model == nil || self.carModel.carid == nil || self.carModel.buytime == nil || self.carModel.frameid == nil || self.carModel.engineid == nil)
//        {
//            [[AlertView sharedAlertView] addAfterAlertMessage:@"请完整填写车辆信息" title:@"提示"];
//            return;
//        }
//        else
//        {
//            [[AFHTTPSessionManager manager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
//             {
//                 NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
//                 
//                 if (data != nil)
//                 {
//                     [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
//                 }
//                 
//             } progress:^(NSProgress * _Nonnull uploadProgress) {
//                 
//             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//             {
//                 YYLog(@"添加爱车返回：%@",responseObject);
//                 
//                 NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
//                 
//                 if (resultCode == 1000)
//                 {
//                     [[AlertView sharedAlertView] addAfterAlertMessage:@"添加爱车成功" title:@"提示"];
//                     [self.navigationController popViewControllerAnimated:YES];
//                     
//                 }
//                 
//             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
//             {
//                 YYLog(@"添加爱车错误：%@",error);
//             }];
//        }
//    }
//    else
//    {
//        [[AlertView sharedAlertView] addAfterAlertMessage:@"有数据为空" title:@"提示"];
//    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.leftLabelArray.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.carImage)
    {
        if (indexPath.section == 0)
        {
            return 0.3 * KScreenHeight + 2 * Klength5;
        }
        
        return 40;
    }
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 1;
    }
    else
    {
        return 15;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.carImage)
        {
            static NSString *identifier0 = @"cell0";
            
            PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
            
            if (cell == nil)
            {
                
                cell = [[PictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier0];
                
            }
            
            cell.pictureView.image = self.carImage;
            
            return cell;
        }
        else
        {
            static NSString *identifier = @"cell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil)
            {
                
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
                
            }
            
            cell.textLabel.text = @"上传照片";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            return cell;
        }
    }
    else
    {
        static NSString *identifier1 = @"cell1";
        
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil)
        {
            cell = [[LabelTextFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        }
        
        cell.leftLabel.text = _leftLabelArray[indexPath.row];
        cell.rightTF.placeholder = _rightPlaceholder[indexPath.row];
        cell.rightTF.delegate = self;
        
        self.carInfoType = indexPath.row;
        cell.rightTF.tag = self.carInfoType;
        
//        switch (self.carInfoType)
//        {
//            case cartype:
//                cell.rightTF.text = self.carModel.cartype;
//                break;
//            case brand:
//               cell.rightTF.text = self.carModel.brand;
//                break;
//            case model:
//               cell.rightTF.text = self.carModel.model;
//                break;
//            case carid:
//               cell.rightTF.text = self.carModel.carid;
//                break;
//            case buytime:
//               cell.rightTF.text = self.carModel.buytime;
//                break;
//            case frameid:
//               cell.rightTF.text = self.carModel.frameid;
//                break;
//            case engineid:
//               cell.rightTF.text = self.carModel.engineid;
//                break;
//                
//            default:
//                break;
//        }
        
        return cell;
    }
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
//        case cartype:
//            self.carModel.cartype = textField.text;
//            break;
//        case brand:
//            self.carModel.brand = textField.text;
//            break;
//        case model:
//            self.carModel.model = textField.text;
//            break;
//        case carid:
//            self.carModel.carid = textField.text;
//            break;
//        case buytime:
//            self.carModel.buytime = textField.text;
//            break;
//        case frameid:
//            self.carModel.frameid = textField.text;
//            break;
//        case engineid:
//            self.carModel.engineid = textField.text;
//            break;
//            
//        default:
//            break;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"从相册获取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 [self getPhotoLibraryImage];
                                             }];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           [self getCameraImage];
                                       }];
        
        [[AlertView sharedAlertView] addAlertMessage:nil title:nil cancleAction:cancleAction photoLibraryAction:photoLibraryAction cameraAction:cameraAction];
    }
}



// 获取照相机图片
- (void)getCameraImage
{
    UIImagePickerController *CameraImage = [[UIImagePickerController alloc] init];
    [CameraImage setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    CameraImage.delegate = self;
    [self presentViewController:CameraImage animated:YES completion:nil];
}
// 获取相册图片
- (void)getPhotoLibraryImage
{
    UIImagePickerController *imgC = [[UIImagePickerController alloc] init];
    [imgC setSourceType:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)];
    imgC.delegate = self;
    [self presentViewController:imgC animated:YES completion:nil];
    
}


// 从照片中获取调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    YYLog(@"image----%@",image);
    self.carImage = image;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    [self.tableView reloadData];
    //    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end



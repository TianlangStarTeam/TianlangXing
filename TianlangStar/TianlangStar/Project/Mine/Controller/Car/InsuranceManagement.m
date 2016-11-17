//
//  InsuranceManagement.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/16.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "InsuranceManagement.h"
#import "InputCell.h"
#import "InsuranceModel.h"
#import "UserHeaderImageCell.h"

typedef enum : NSUInteger {
    expenses = 0,
    payment,
    buytime,
    policyid,
    continuetime
} InsuranceType;

@interface InsuranceManagement ()<UITextFieldDelegate>

/** 左侧的数组信息 */
@property (nonatomic,strong) NSArray *leftArr;


/** 标记输入框是否可用 */
@property (nonatomic,assign) BOOL inputEnble;


/** 接收到的保险类型 */
@property (nonatomic,strong) InsuranceModel *insuranceModel;


/** 接收到的保险数据 */
@property (nonatomic,strong) NSMutableArray *insuranceArr;



/** 保险的枚举类型 */
@property (nonatomic,assign) InsuranceType selectedData;


/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *insuranceidData;

/** 险种的类型 */
@property (nonatomic,assign) NSInteger insuranceType;

@end

@implementation InsuranceManagement

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.insuranceType = 1;
    [self addTitleView];
    
    [self loadData];
    
    [self addRightBar];

    [self addDatePIcker];
}


-(InsuranceModel *)insuranceModel
{
    if (!_insuranceModel)
    {
        _insuranceModel = [[InsuranceModel alloc] init];
    }
    return _insuranceModel;
}



//设置顶部的分割按钮
-(void)addTitleView
{
    NSArray *arr = [NSArray arrayWithObjects:@"交强险",@"商业险",nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.frame = CGRectMake(0, 10, 100, 30);
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    segment.apportionsSegmentWidthsByContent = YES;
    
    //设置默认选择较强险
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
}

-(void)segmentChange:(UISegmentedControl *)segment
{
    
    switch (segment.selectedSegmentIndex) {
        case 0://强险
            self.insuranceType = 1;
            break;
        case 1://强险
            self.insuranceType = 2;
            break;
            
        default:
            break;
    }
    YYLog(@"self.type---%ld",(long)self.insuranceType);
    
    [self loadData];
}




/**
 *  添加时间选择器
 */
-(void)addDatePIcker
{
    //日期选择器
    //iphone6/6s
    UIDatePicker *startDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,KScreenHeight ,KScreenWidth, 162)];
    
    startDatePicker.datePickerMode=UIDatePickerModeDate;
    startDatePicker.date=[NSDate date];
    self.insuranceidData.hidden = NO;
    self.insuranceidData = startDatePicker;
    
    //计算当前时间
//    NSDate *nowdate = [NSDate date];
//    //    限制起始时间为当前时间
//    self.insuranceidData.maximumDate = nowdate;
    [self.insuranceidData addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}


/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * time=[outputFormatter stringFromDate:self.insuranceidData.date];
//    //更改输入框的数据
//    //    self.textArr[_selectData] = time;
//    [self.textArr replaceObjectAtIndex:_selectData withObject:time];
    
    //记录数据
    switch (self.selectedData)
    {
        case buytime://投保日期
        {
            self.insuranceModel.buytime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case continuetime://续保日期
        {
            self.insuranceModel.continuetime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }

            
        default:
            break;
    }
    
    //回到主线程刷新数据，刷新对应的单元格
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //        [self.tableView reloadData];
        //单个单元格刷新
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.selectedData inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:(UITableViewRowAnimationNone)];
    });
}


-(void)addRightBar
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(rightBarClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightBarClick:(UIButton *)button
{
    [self.view endEditing:YES];
    
    self.inputEnble = !button.selected;
    
    button.selected = !button.selected;
    
    //刷新数据
    [self.tableView reloadData];
    
    if (self.inputEnble == NO)//是显示完成
    {
        [self updataUserInfo];
    }
}


#pragma mark=============初始化请求数据=====================
-(void)loadData
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parmas[@"sessionId"] = userInfo.RSAsessionId;
    parmas[@"id"] = self.carID;
    parmas[@"type"] = @(self.insuranceType);
    NSString *url = [NSString stringWithFormat:@"%@querycarinsuranceservlet",URL];
    
    YYLog(@"parmas-----%@",parmas);
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         self.insuranceArr = [InsuranceModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         if (self.insuranceType == 1)
         {
             self.insuranceModel = self.insuranceArr[0];
         }
         
         YYLog(@"%@",json);
         YYLog(@"self.insuranceModel.insurancetype---%@",self.insuranceModel.insurancetype);
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error)
     {
         YYLog(@"%@",error);
     }];

}

//更新数据

#pragma mark=============更新数据=====================
-(void)updataUserInfo
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    parmas[@"sessionId"] = userInfo.RSAsessionId;
    parmas[@"id"] = @"16";
    parmas[@"type"] = @"1";
    NSString *url = [NSString stringWithFormat:@"%@querycarinsuranceservlet",URL];

    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
//         NSData *data = UIImageJPEGRepresentation(self.carImage, 0.5);
         
//         if (data != nil)
//         {
//             [formData appendPartWithFileData:data name:@"picture" fileName:@"img.jpg" mimeType:@"image/jpeg"];
//         }
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"添加爱车返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [[AlertView sharedAlertView] addAfterAlertMessage:@"添加爱车成功" title:@"提示"];
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"添加爱车错误：%@",error);
     }];

    
    
    
}


-(NSArray *)leftArr
{
    if (!_leftArr) {
        _leftArr = @[@"险种",@"投保公司",@"投保日期",@"投保单号",@"续保日期"];
    }
    return _leftArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 1;
    if (self.insuranceType == 1)
    {
        count = 2;
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.insuranceType == 1)
    {
        NSInteger count = 1;
        
        if (section == 1)
        {
            count = self.leftArr.count;
        }
        return count;

    }else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.insuranceType == 2)//较强险
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        InsuranceModel *model = self.insuranceArr[indexPath.row];
        cell.textLabel.text = model.company;
        
        return cell;
    }else
    {
        if (indexPath.section == 0)
        {
            UserHeaderImageCell *cell = [[UserHeaderImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.headerPic sd_setImageWithURL:[NSURL URLWithString:self.insuranceModel.images] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            return cell;
            
        }else
        {
            InputCell *cell = [InputCell cellWithTableView:tableView];
            
            cell.leftLB.text = self.leftArr[indexPath.row];
            cell.leftLB.width = 100;
            cell.textField.x = KScreenWidth * 0.25;
            self.selectedData = indexPath.row;
            cell.textField.tag = self.selectedData;
            cell.textField.delegate = self;
            cell.textField.textAlignment = NSTextAlignmentRight;
            //设置数据
            switch (self.selectedData)
            {
                case expenses:
                    cell.leftLB.text = self.insuranceModel.insurancetype;
                    cell.textField.text = self.insuranceModel.expenses;
                    
                    break;
                case payment:
                    cell.textField.text = self.insuranceModel.company;
                    break;
                case buytime:
                {
                    cell.textField.text = [self.insuranceModel.buytime getTime];
                    break;
                }
                case policyid:
                    cell.textField.text = self.insuranceModel.policyid;
                    break;
                case continuetime:
                    cell.textField.text = [self.insuranceModel.continuetime getTime];
                    break;
                    
                    
                default:
                    break;
            }
            return cell;
        }
    }

   }

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
}



#pragma mark=========taxtField 的代理方法=================
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    switch (textField.tag)
    {
        case expenses:
            self.insuranceModel.expenses = textField.text;
            break;
            
        case payment:
            self.insuranceModel.payment = textField.text;
            break;
        case policyid:
            self.insuranceModel.policyid = textField.text;
            break;
            
        default:
            break;
    }

}


/**
 *  当输入框的文字发生改变的时候调用，弹出时间选择器--下面为了防止UItextfield弹出键盘
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == buytime || textField.tag ==continuetime )
    {
        textField.inputView=self.insuranceidData;
        self.selectedData = textField.tag;
        textField.placeholder = @"请选择日期";
    }else
    {
        [self.insuranceidData removeFromSuperview];
    }
    return YES;
}



@end

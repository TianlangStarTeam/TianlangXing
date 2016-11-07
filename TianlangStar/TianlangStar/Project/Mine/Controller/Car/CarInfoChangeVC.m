//
//  CarInfoChangeVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "CarInfoChangeVC.h"
#import "CarInputCell.h"
#import "CarModel.h"


@interface CarInfoChangeVC ()<UITextFieldDelegate>

/** 单元格左侧的描述 */
@property (nonatomic,strong) NSArray *rightArr;

/** 提交按钮 */
@property (nonatomic,strong) UIButton *handButton;


/** 较强险提醒日期 --时间戳 */
@property (nonatomic,strong) UIDatePicker *insuranceidData;

/** 商业险提醒日期 --时间戳*/
@property (nonatomic,strong) UIDatePicker *commercialtimeData;

/** 车辆的购买日期日期 */
@property (nonatomic,copy) NSString *buytime;

/** 较强险的提醒日期 */
@property (nonatomic,copy) NSString *insuranceid;
/** 较强险的提醒日期 */
@property (nonatomic,copy) NSString *commercialtime;


/** 记录输入框的内容 */
@property (nonatomic,strong) NSMutableArray *textArr;


/** 记录用户年月入日期选择器 */
@property (nonatomic,assign) NSInteger selectData;

@end

@implementation CarInfoChangeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"车辆信息修改";

    [self addFooter];
    [self addDatePIcker];
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
    NSDate *nowdate = [NSDate date];
    //限制起始时间为当前时间
//    self.insuranceidData.minimumDate = nowdate;
    [self.insuranceidData addTarget:self action:@selector(selecStarttDate) forControlEvents:UIControlEventValueChanged];
}

/** 时间选择器的点击事件--较强险提醒日期 */
-(void)selecStarttDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    switch (self.selectData)
    {
        case 6://购买日期
        {
            self.buytime=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carInfo.buytime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case 8://较强险
        {
            self.insuranceid=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carInfo.insurancetime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
        case 9://商业险
        {
            self.commercialtime=[outputFormatter stringFromDate:self.insuranceidData.date];
            self.carInfo.commercialtime = [NSString stringWithFormat:@"%ld", (long)[self.insuranceidData.date timeIntervalSince1970]];
            break;
        }
            
        default:
            break;
    }

    //回到主线程刷新数据
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
    
}




-(NSMutableArray *)textArr
{
    if (_textArr == nil)
    {
        _textArr = [NSMutableArray array];
        
        //购买时间
        NSString *buytime = [self.carInfo.insurancetime getTime];
        //较强险
        NSString *insurancetime = [self.carInfo.insurancetime getTime];
        //商业险
        NSString *commercialtime = [self.carInfo.commercialtime getTime];
        
        NSArray *arr = @[self.carInfo.carid,self.carInfo.brand,self.carInfo.model,self.carInfo.cartype,self.carInfo.frameid,self.carInfo.engineid,buytime,self.carInfo.insuranceid,insurancetime,commercialtime];
        _textArr = (NSMutableArray *)arr;
    }
    return _textArr;
}


-(NSArray *)rightArr
{
    if (_rightArr == nil)
    {
        _rightArr = @[@"车牌号",@"品牌",@"型号",@"车型",@"车架号",@"发动机号",@"购买年份",@"保险信息",@"较强险提醒日期",@"商业险提醒日期"];
    }
    
    return _rightArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)addFooter
{
    UIView *handView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth, 44)];
    self.handButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.handButton.frame = CGRectMake(0, 20, KScreenWidth * 0.6, 30);
    self.handButton.centerX = KScreenWidth * 0.5;
    //    self.handButton.centerY = handView.height * 0.5;
    [self.handButton setTitle:@"提交" forState:(UIControlStateNormal)];
    self.handButton.backgroundColor = [UIColor orangeColor];
    [self.handButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.handButton addTarget:self action:@selector(handAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.handButton.backgroundColor = XLXcolor(44, 171, 63);
    self.handButton.layer.cornerRadius = 6;
    [self.handButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //    handView.backgroundColor = [UIColor grayColor];
    [handView addSubview:self.handButton];
    self.tableView.tableFooterView = handView;
}

- (void)handAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (self.carInfo.carid == nil        || self.carInfo.carid.length == 0   ||
        self.carInfo.brand == nil        || self.carInfo.brand.length == 0   ||
        self.carInfo.model == nil        || self.carInfo.model.length == 0   ||
        self.carInfo.cartype == nil      || self.carInfo.cartype.length == 0 ||
        self.carInfo.frameid == nil      || self.carInfo.frameid.length == 0 ||
        self.carInfo.engineid == nil     || self.carInfo.engineid.length == 0   ||
        self.carInfo.buytime == nil      || self.carInfo.buytime.length == 0   ||
        self.carInfo.insuranceid == nil  || self.carInfo.insuranceid.length == 0 ||
        self.carInfo.insurancetime == nil || self.carInfo.insurancetime.length == 0||
        self.carInfo.commercialtime == nil || self.carInfo.commercialtime.length == 0
        )
    {
        [[AlertView sharedAlertView] addAlertMessage:@"输入框有空，请核对" title:@"提示"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sessionId"] = [UserInfo sharedUserInfo].RSAsessionId;
    params[@"id"] = self.carInfo.ID;
    params[@"userid"] = [UserInfo sharedUserInfo].userID;
    params[@"carid"] = self.carInfo.carid;
    params[@"brand"] = self.carInfo.brand;
    params[@"model"] = self.carInfo.model;
    params[@"cartype"] = self.carInfo.cartype;
    params[@"frameid"] = self.carInfo.frameid;
    params[@"engineid"] = self.carInfo.engineid;
    params[@"buytime"] = self.carInfo.buytime;
    params[@"insuranceid"] = self.carInfo.insuranceid;
    params[@"insurancetime"] = self.carInfo.insurancetime;
    params[@"commercialtime"] = self.carInfo.commercialtime;
    
    NSString *url = [NSString stringWithFormat:@"%@updatecarinfoservlet",URL];
    YYLog(@"params----%@",params);
    [[AFHTTPSessionManager manager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"responseObject---%@",responseObject);
         NSNumber *num = responseObject[@"resultCode"];
         NSInteger result = [num integerValue];
         if (result == 1000)
         {
             [SVProgressHUD showSuccessWithStatus:@"提交成功"];
         }else if (result == 1007)
         {
             [[AlertView sharedAlertView] loginUpdataSession];
         }else
         {
             [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"error----%@",error);
     }];
    
    
    
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
    NSString *nameInput = self.textArr[indexPath.row];
    cell.textField.text = nameInput;
    
    cell.textLabel.text = name;
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    
    switch (indexPath.row) {
        case 6:
        {
            if (self.buytime)
            {
                cell.textField.text = self.buytime;
            }
            break;
        }
        case 8:
        {
            if (self.insuranceid)
            {
                cell.textField.text = self.insuranceid;
            }
            break;
        }
        case 9:
        {
            if (self.commercialtime)
            {
                cell.textField.text = self.commercialtime;
            }
            break;
        }
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    
    return cell;
}


#pragma mark====设置textField的代理事件的处理并传值

//保存用户输入的信息
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //    self.textArr[textField.tag] = textField.text;
    
    switch (textField.tag) {
        case 0:
            self.carInfo.carid = textField.text;
            break;
        case 1:
            self.carInfo.brand = textField.text;
            break;
        case 2:
            self.carInfo.model = textField.text;
            break;
        case 3:
            self.carInfo.cartype = textField.text;
            break;
        case 4:
            self.carInfo.frameid = textField.text;
            break;
        case 5:
            self.carInfo.engineid = textField.text;
            break;
//        case 6:
//            self.carInfo.buytime = textField.text;
//            break;
        case 7:
            self.carInfo.insuranceid = textField.text;
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
    if (textField.tag == 8 || textField.tag == 9 || textField.tag == 6)
    {
        textField.inputView=self.insuranceidData;
        self.selectData = textField.tag;
        textField.placeholder = @"请选择日期";
    }else
    {
        [self.insuranceidData removeFromSuperview];
    }
    return YES;
}



@end

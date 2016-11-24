//
//  OkOrderVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/23.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "BossOkdetailOrderVC.h"
#import "OrderModel.h"

@interface BossOkdetailOrderVC ()


/** 用户名 */
@property (nonatomic,weak) UILabel *username;

@end

@implementation BossOkdetailOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"确认订单";
    self.view.backgroundColor = BGcolor;
    
    [self setupControls];
}


-(void)setupControls
{
    //设置数据
    NSArray *Arr= @[@"用户名:",@"手机号:",@"商品名称:",@"交易时间:",@"交易单号:",@"交易金额:"];
    
    //设置左边的Lable
    CGFloat margin = 30;
    CGFloat startY = 80;
    for (NSInteger i = 0; i < Arr.count; i++)
    {
        //设置左边的标签数据
        UILabel *lable = [[UILabel alloc] init];
        lable.width = 80;
        lable.height = 45;
        lable.x = margin;
        lable.y = startY + i * lable.height;
        lable.textAlignment = NSTextAlignmentRight;
        lable.text = Arr[i];
        //        lable.backgroundColor = [UIColor redColor];
        [self.view addSubview:lable];
        
        //设置右边的数据
        UILabel *rightlable = [[UILabel alloc] init];
        rightlable.width = 200;
        rightlable.height = 45;
        rightlable.x = CGRectGetMaxX(lable.frame) + 10;
        rightlable.y = startY + i * lable.height;
//        rightlable.text = @"796234796";
//        rightlable.backgroundColor = [UIColor redColor];
        
        //设置数据
        switch (i) {
            case 0:
                rightlable.text = self.orderModel.membername;
                break;
            case 1:
                rightlable.text = self.orderModel.username;
                break;
            case 2:
                rightlable.text = self.orderModel.productname;
                break;
            case 3:
                rightlable.text = self.orderModel.date;
                break;
            case 4:
                rightlable.text = self.orderModel.saleid;
                break;
            case 5:
                rightlable.text = self.orderModel.price;
                break;
                
            default:
                break;
        }
        
        
        [self.view addSubview:rightlable];
    }
    
    
    //设置顶部的确认取消按钮
    CGFloat height = 50;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - height, KScreenWidth, height)];
    [self.view addSubview:bottomView];
    CGFloat Width = (KScreenWidth - 1) /2;
    UIButton *cancelbutton = [[UIButton alloc] init];
    cancelbutton.x = 0;
    cancelbutton.y = 0;
    cancelbutton.width = Width;
    cancelbutton.height = height;
    [cancelbutton setTitle:@"取消确认" forState:UIControlStateNormal];
    [cancelbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelbutton.backgroundColor = [UIColor whiteColor];
    cancelbutton.layer.cornerRadius = BtncornerRadius;
    cancelbutton.layer.masksToBounds = YES;
    [cancelbutton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelbutton];
    
    //确认订单
    UIButton *okbutton = [[UIButton alloc] init];
    okbutton.x = Width + 1;
    okbutton.y = 0;
    okbutton.width = Width;
    okbutton.height = height;
    [okbutton setTitle:@"确认订单" forState:UIControlStateNormal];
    okbutton.backgroundColor = [UIColor whiteColor];
    okbutton.layer.cornerRadius = BtncornerRadius;
    okbutton.layer.masksToBounds = YES;
    [okbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okbutton addTarget:self action:@selector(okbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:okbutton];
}


//取消确认点击事件的处理
-(void)cancelBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


//取消确认点击事件的处理
-(void)okbuttonClick
{
    YYLog(@"QUEREN");
}




@end

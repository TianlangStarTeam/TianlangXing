//
//  MembersTVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "MembersTVC.h"
#import "CarInputCell.H"

@interface MembersTVC ()<UITextFieldDelegate>

/** 输入框数组 */
@property (nonatomic,strong) NSMutableArray *rankArr;


/** 判断文本框是否可编辑 */
@property (nonatomic,assign) BOOL textEnable;


/** 折扣数组 */
@property (nonatomic,strong) NSMutableArray *discountArr;



@end

@implementation MembersTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textEnable = NO;
        YYLog(@"textEnable--%d",self.textEnable);
    self.view.backgroundColor = [UIColor whiteColor];

    [self addRightBar];
    
    [self addheaderView];
    
}

- (void)addRightBar
{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
}

- (void)rightClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.textEnable = button.selected;
    
    YYLog(@"textEnable--%d",self.textEnable);
    
    for (UITextField *input in self.discountArr)
    {
        input.enabled  = self.textEnable;
    }

    if (self.textEnable)
    {
        UITextField *input = self.discountArr[0];
        [input becomeFirstResponder];
    }else
    {
        [self.view endEditing:YES];
    }
    
    
    
}




//添加顶部
- (void)addheaderView
{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 44)
                      ];
//    header.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:header];
    
    UILabel * rank = [[UILabel alloc] init];
    rank.height = 30;
    rank.width = KScreenWidth * 0.5;
    rank.centerY = header.height * 0.5;
    rank.x = 0;
    rank.text = @"会员等级";
    rank.font = Font16;
    rank.textAlignment = NSTextAlignmentCenter;
    [header addSubview:rank];
    
    
    UILabel * discount = [[UILabel alloc] init];
    discount.height = 30;
    discount.width = KScreenWidth * 0.5;
    discount.y = rank.y;
//    discount.x = KScreenWidth * 0.5;
    discount.centerX = KScreenWidth * 0.65;
    discount.text = @"折扣      ";
    discount.font = rank.font;
    discount.textAlignment = rank.textAlignment;
    [header addSubview:discount];
    

    
    
    //会员等级列表
    self.rankArr = [NSMutableArray array];
    NSArray *rankArr =@[@"Lv.1",@"Lv.2",@"Lv.3",@"Lv.4",@"Lv.5"];
    double rankOY = CGRectGetMaxY(header.frame);
    
    for (NSInteger i = 0; i < rankArr.count; i++)
    {
        UILabel *rank  = [[UILabel alloc] init];
        rank.text = rankArr[i];
        rank.x = 0;
        rank.width = KScreenWidth * 0.5;
        rank.height = 30;
        rank.y = rankOY + 10 + i * 45;
        rank.textAlignment = NSTextAlignmentCenter;
        [self.rankArr addObject:rank];
        YYLog(@"%lu",(unsigned long)self.rankArr.count);
        [self.view addSubview:rank];
    }
    
    //折扣输入框列表
    NSArray *discountA = @[@"9",@"8",@"7",@"6",@"5"];
    CGFloat margin = 20;
    CGFloat inputX = KScreenWidth * 0.5 - margin;
    CGFloat inputW = KScreenWidth * 0.5 - 2 * margin;
    
    self.discountArr = [NSMutableArray array];
    for (NSInteger i = 1; i <= discountA.count; i++)
    {
        UITextField *input = [[UITextField alloc] init];
        input.enabled = self.textEnable;
//        input.backgroundColor = [UIColor orangeColor];
//        input.x = inputX;
        input.y = rankOY + 10 + (i - 1) * 45;
        input.width = inputW;
        input.height = 30;
        input.centerX = KScreenWidth * 0.65;
        input.tag = i;
        input.delegate = self;
        input.textAlignment = NSTextAlignmentCenter;
        [self.discountArr addObject:input];
        input.placeholder = @"请输入信息";
        YYLog(@"self.discountArr.count-%lu",(unsigned long)self.discountArr.count);
        input.text = discountA[i-1];
        [self.view addSubview:input];
    }
    
    
    
    
    
    
    //底部的完成按钮
   UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KScreenHeight  - 44, KScreenWidth, 44)];
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    okBtn.backgroundColor = [UIColor redColor];
    [okBtn addTarget:self action:@selector(OKbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];

}

- (void)OKbtnClick
{

    YYLog(@"完成的点击事件");
}

//退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark======文本框输入的文字处理事件=====

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    YYLog(@"%ld",(long)textField.tag);
    YYLog(@"%@",textField.text);

}

@end

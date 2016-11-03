//
//  FeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/3.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitBtnClick:(UIButton *)sender
{
    YYLog(@"提交");
    
    YYLog(@"%@",self.textView.text);
}


@end

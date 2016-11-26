//
//  ReFeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ReFeedbackVC.h"
#import "FeedbackView.h"
#import "FeedbackModel.h"

@interface ReFeedbackVC ()



@end

@implementation ReFeedbackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"未回复";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupControls];
}

//设置子控件
-(void)setupControls
{
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(10, 80, KScreenWidth - 20, self.feedbackModel.textH)];
    
    
    view.feedbackModel = self.feedbackModel;
//    view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:view];


}


@end

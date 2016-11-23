//
//  ReFeedbackVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/22.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "ReFeedbackVC.h"
#import "FeedbackView.h"

@interface ReFeedbackVC ()



@end

@implementation ReFeedbackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"反馈回执";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupControls];
}

//设置子控件
-(void)setupControls
{
    FeedbackView *view = [[FeedbackView alloc] initWithFrame:CGRectMake(10, 80, KScreenWidth - 20, 200)];
    view.feedbackModel = self.feedbackModel;
//    view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:view];


}


@end

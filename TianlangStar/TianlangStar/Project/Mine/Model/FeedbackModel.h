//
//  FeedbackModel.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//  用户意见模型

#import <Foundation/Foundation.h>

@interface FeedbackModel : NSObject


/** 已回复-未回复 */
@property (nonatomic,assign) BOOL flag;

/** 用户意见列表的ID */
@property (nonatomic,copy) NSString *ID;

/** 上次回复时间 */
@property (nonatomic,copy) NSString *lasttime;

/** 意见内容 */
@property (nonatomic,copy) NSString *content;

/** 用户的id */
@property (nonatomic,copy) NSString *userid;


@end

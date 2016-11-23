//
//  FeedbackModel.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/11.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "FeedbackModel.h"

@implementation FeedbackModel



+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"ID" : @"id" };
}


-(NSString *)lasttime
{
    NSTimeInterval _interval = [_lasttime doubleValue] / 1000;
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    return [formatter stringFromDate:data];
}






@end

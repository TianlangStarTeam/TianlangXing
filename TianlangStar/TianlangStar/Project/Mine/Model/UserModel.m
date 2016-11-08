//
//  userModel.m
//  房地产-新旅行
//
//  Created by xinlvxing on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "UserModel.h"
#import <MJExtension.h>

@implementation UserModel




+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID": @"id",
             @"describe": @"description"
             };
    
}

-(NSString *)headerpic
{
    return [NSString stringWithFormat:@"%@%@",picURL,_headerpic];
}


-(NSString *)lasttime
{
    NSString * timeStampString = _lasttime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    
    return [objDateformat stringFromDate: date];
}
















- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end

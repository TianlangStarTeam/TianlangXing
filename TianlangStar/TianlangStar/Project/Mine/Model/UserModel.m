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
@end

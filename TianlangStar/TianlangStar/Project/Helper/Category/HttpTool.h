//
//  HttpTool.h
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject


/** 发送简单的不含图片的请求 */
+ (void)post:(NSString *)url parmas:(NSDictionary *)parmas success:(void (^)(id json))success failure:(void(^) (NSError *error))failure;

@end

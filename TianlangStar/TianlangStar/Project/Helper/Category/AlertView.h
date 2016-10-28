//
//  AlertView.h
//  TianlangStar
//
//  Created by youyousiji on 16/10/26.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertView : NSObject
singleton_interface(AlertView);

///** 快速创建一个提示 */
//+(instancetype)alert;

/** 提示先登录 */
- (void)loginAlertView;


/** 自动登录 */
- (void)loginUpdataSession;



/**
 *  @param message 提示信息
 *  @param title   标题
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title;





@end

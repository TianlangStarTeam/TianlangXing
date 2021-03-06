//
//  UWDatePickerView.h
//  UWDatePickerView
//
//  Created by Fengur on 15/11/04.
//  Copyright © 2015年 Fengur. All rights reserved.
//


/**
 *
 ----------------------------------------------------------------------------------------------------
 |
 |   在调用datePicker的地方实现 setupDateView 方法，并调用，可在方法内自定义颜色，外观，字体，时间最大值及最小值。
 |   同时需要实现时间确定选择后的代理方法 getSelectDate 该方法用来处理时间确认选择和取消选择的事件
 ----------------------------------------------------------------------------------------------------
 */


#import <UIKit/UIKit.h>
typedef enum{
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
}DateType;

@protocol UWDatePickerViewDelegate <NSObject>

/**
 *  选择日期确定后的代理事件
 *
 *  @param date 日期
 *  @param type 时间选择器状态
 */
- (void)getSelectDate:(NSString *)date type:(DateType)type button:(UIButton *)button;

@end

@interface UWDatePickerView : UIView

//如果在一个界面多次使用时间选择器，可以通过定义一个属性标记点击的cell的indexPath.row


+ (UWDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<UWDatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateType type;

@end
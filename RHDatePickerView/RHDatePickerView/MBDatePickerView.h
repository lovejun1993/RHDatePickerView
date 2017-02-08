//
//  MBDatePickerView.h
//  MeetingBar
//
//  Created by Rhino on 2016/11/7.
//  Copyright © 2016年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBDatePickerView;

@protocol MBDatePickerViewDelegate <NSObject>

//当时间改变时触发
- (void)changeTime:(NSDate *)date;
- (void)cancleDeterMinePicker;

@required
//确定时间
- (void)determine:(NSDate *)date picker:(MBDatePickerView *)picker;

@end

@interface MBDatePickerView : UIView

@property (assign,nonatomic) id<MBDatePickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate;
//显示
- (void)show;


@end

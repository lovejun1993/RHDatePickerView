//
//  RHDatePickerTool.h
//  RHDatePickerView
//
//  Created by Rhino on 2017/1/13.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHDatePickerTool : NSObject



+(NSArray *)daysFromNowToDeadLine:(NSString *)deadLine currIndex:(int)currIndex;

+(int)currentDateHour;

+(int)currentDateMinute;

+(NSString *)displayedSummaryTimeUsingString:(NSString *)string;
+(NSString *)summaryTimeUsingDate2;


@end

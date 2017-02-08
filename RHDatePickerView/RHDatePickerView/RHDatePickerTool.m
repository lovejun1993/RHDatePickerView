//
//  RHDatePickerTool.m
//  RHDatePickerView
//
//  Created by Rhino on 2017/1/13.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "RHDatePickerTool.h"
#define MAXCOUNTDAYS 100

@implementation RHDatePickerTool

////返回日期天数的数组
+(NSArray *)daysFromNowToDeadLine:(NSString *)deadLine currIndex:(int)currIndex{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyyMMdd"];
    //开始时间
    NSDate *startDate = [f dateFromString:[self summaryTimeUsingDate:[NSDate date]]];
    //结束时间
    NSDate *endDate = [f dateFromString:deadLine];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    NSInteger diffDays = components.day;
    //当前日期
    if(diffDays==0) return @[[self summaryTimeUsingDate:[NSDate date]]];
    
    NSMutableArray *dayArray = [NSMutableArray array];
    //最多100天
    if(diffDays > MAXCOUNTDAYS) diffDays = MAXCOUNTDAYS;
    //当前选择的日期
    for (int i = currIndex; i <= diffDays; i++) {
        NSTimeInterval  iDay = 24*60*60*i;  //1天的长度
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:iDay];
        [dayArray addObject:[self summaryTimeUsingDate:date]];
    }
    return dayArray;
}

//当前时间 几时
+(int)currentDateHour{
    return (int)[self dateComponents].hour;
}
//当前时间 几分
+(int)currentDateMinute{
    return (int)[self dateComponents].minute;
}

+(NSDateComponents *)dateComponents{
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    return dateComponent;
}


/**
 时间格式化

 @param date 时间
 @return 字符串
 */
+(NSString *)summaryTimeUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)summaryTimeUsingDate1:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)summaryTimeUsingDate2
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval  interval = 24*60*60*30; //1:天数
    NSDate*date1 = [currentDate initWithTimeIntervalSinceNow:+interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date1];
    return dateString;
}

/////将日期字符串格式化为年月日 20170114 --> 2017年01月14日
+(NSString *)displayedSummaryTimeUsingString:(NSString *)string
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:[string substringWithRange:NSMakeRange(0, 4)]];
    [result appendString:@"年"];
    [result appendString:[string substringWithRange:NSMakeRange(4, 2)]];
    [result appendString:@"月"];
    [result appendString:[string substringWithRange:NSMakeRange(6, 2)]];
    [result appendString:@"日"];
    return result;
}


@end

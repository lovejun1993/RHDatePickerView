//
//  MBDatePickerView.m
//  MeetingBar
//
//  Created by Rhino on 2016/11/7.
//  Copyright © 2016年 Rhino. All rights reserved.
//

#import "MBDatePickerView.h"
#import "RHDatePickerTool.h"
#import "NSDate+YYAdd.h"

#define HOURARRAY @[@"0时", @"1时", @"2时", @"3时", @"4时", @"5时", @"6时", @"7时", @"8时", @"9时", @"10时", @"11时", @"12时", @"13时", @"14时", @"15时", @"16时", @"17时", @"18时", @"19时", @"20时", @"21时", @"22时", @"23时"]
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define HEIGHTCOUNT 0.5

#define kZero 0
#define kFullWidth [UIScreen mainScreen].bounds.size.width
#define kFullHeight [UIScreen mainScreen].bounds.size.height

#define kDatePicY kFullHeight/3*2
#define kDatePicHeight kFullHeight/3

#define kDateTopBtnY kDatePicY - 30
#define kDateTopBtnHeight 30

#define kDateTopRightBtnWidth kDateTopLeftBtnWidth
#define kDateTopRightBtnX kFullWidth - 0 - kDateTopRightBtnWidth

#define kDateTopLeftbtnX  0
#define kDateTopLeftBtnWidth kFullWidth/6

@interface MBDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong)UIView   *groundV;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIView   *topView;
@property (nonatomic,strong)UILabel  *titleLabel;


@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *minutes;
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *showDayArray;
@property (nonatomic, strong) NSArray *hourArray;
@property (nonatomic, strong) NSArray *minuteArray;

//最大和最小时间
@property (nonatomic,strong) NSDate *optionalMaxDate;
@property (nonatomic,strong) NSDate *optionalMinDate;

@end


@implementation MBDatePickerView

- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate{
    self = [super initWithFrame:frame];
    if (self) {
        self.optionalMaxDate = maxDate;
        self.optionalMinDate = minDate;
        [self addSubview:self.groundV];
        [self initData];
        [self addSubview:self.pickerView];
        [self addSubview:self.topView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)end{
    [self removeFromSuperview];
}

- (void)handleDateP :(NSDate *)date {
//    if ([self.delegate respondsToSelector:@selector(changeTime:)]) {
//        [self.delegate changeTime:self.dateP.date];
//    }
//    
}
//////取消
- (void)handleDateTopViewLeft {
    [self end];
    if ([self.delegate respondsToSelector:@selector(cancleDeterMinePicker)]) {
        [self.delegate cancleDeterMinePicker];
    }
}

/////确定
- (void)handleDateTopViewRight {
    NSInteger firstIndex = [_pickerView selectedRowInComponent:0];
    NSInteger secodnIndex = [_pickerView selectedRowInComponent:1];
    NSInteger thirdIndex = [_pickerView selectedRowInComponent:2];
    
    NSMutableString *dateValue = [[NSMutableString alloc] initWithString:_showDayArray[firstIndex]];
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:dateValue];
    [result appendString:[NSString stringWithFormat:@" %@",_hourArray[secodnIndex]]];
    [result appendString:[NSString stringWithFormat:@"%@",_minuteArray[thirdIndex]]];
    
    if ([self.delegate respondsToSelector:@selector(determine: picker:)]) {
        [self.delegate determine:[self dateFromString:result] picker:self];
    }
    [self end];
}
// NSDate --> NSString
- (NSString*)stringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//NSDate <-- NSString
- (NSDate*)dateFromString:(NSString*)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

#pragma mark - pickerview data and delegate
-(void)initData{
    //分钟 数组
    self.minutes = [[NSMutableArray alloc]init];
    for (int i=0; i<60; i++) {
        [self.minutes addObject:[NSString stringWithFormat:@"%d分",i]];
    }
    //天 日期的数组
    _dayArray = [RHDatePickerTool daysFromNowToDeadLine:[RHDatePickerTool summaryTimeUsingDate2] currIndex:0];
    _showDayArray = [self genShowDayArrayByDayArray:_dayArray];
    
    _hourArray = [self validHourArray];
    _minuteArray = [self validMinuteArray];
}
//日期的数组
-(NSArray *)genShowDayArrayByDayArray:(NSArray *)dayArray{
    NSMutableArray *showDayArray = [[NSMutableArray alloc]init];
    for (int i = 0; i< dayArray.count; i++) {
        [showDayArray addObject:[RHDatePickerTool displayedSummaryTimeUsingString:dayArray[i]]];
    }
    return showDayArray;
}

//小时的数组
-(NSArray *)validHourArray
{
    NSInteger startIndex = self.optionalMinDate.hour;
    if (self.optionalMinDate.minute >= 60) startIndex++;
    return [HOURARRAY subarrayWithRange:NSMakeRange(startIndex, HOURARRAY.count - startIndex)];
}
//分钟的数组
-(NSArray *)validMinuteArray
{
    NSInteger startIndex = self.optionalMinDate.minute +1;
    if (self.optionalMinDate.minute >= 60)
        startIndex = 0;
    return [self.minutes subarrayWithRange:NSMakeRange(startIndex, self.minutes.count - startIndex)];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.showDayArray.count;
        case 1:
            return self.hourArray.count;
        case 2:
            return self.minuteArray.count;
        default:
            return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger firstComponentSelectedRow = [self.pickerView selectedRowInComponent:0];
    if (firstComponentSelectedRow == 0) {
        _hourArray = [self validHourArray];
        _minuteArray = [self validMinuteArray];
        NSInteger secondComponentSelectedRow = [self.pickerView selectedRowInComponent:1];
        if (secondComponentSelectedRow == 0 || component ==0) {
            _minuteArray = [self validMinuteArray];
        }else{
            _minuteArray = self.minutes;
        }
    }else{
        _hourArray = HOURARRAY;
        _minuteArray = self.minutes;
    }
    [self.pickerView reloadAllComponents];
    
    //当第一列滑到第一个位置时，第二，三列滚回到0位置
    if(component == 0){
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    if (view) {
        label = (UILabel *)view;
    }else{
        label = [[UILabel alloc] init];
    }
    label.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            label.text = self.showDayArray[row];
            break;
        case 1:
            label.text = self.hourArray[row];
            break;
        case 2:
            label.text = self.minuteArray[row];
            break;
        default:
            break;
    }
    
    return label;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return self.frame.size.width/2.0;
    }else{
        return self.frame.size.width/4.0;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}



#pragma mark - setter/getter
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(kZero, kDatePicY, kFullWidth, kDatePicHeight)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor  = [UIColor whiteColor];
    }
    return _pickerView;
}
- (UIView *)groundV {
    if (!_groundV) {
        self.groundV = [[UIView alloc]initWithFrame:self.bounds];
        self.groundV.backgroundColor = [UIColor blackColor];
        self.groundV.alpha = 0.7;
    }
    return _groundV;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = CGRectMake(kDateTopLeftbtnX, kDateTopBtnY, kDateTopLeftBtnWidth, kDateTopBtnHeight);
        [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(handleDateTopViewLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(kDateTopRightBtnX, kDateTopBtnY, kDateTopRightBtnWidth, kDateTopBtnHeight);
        [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(handleDateTopViewRight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UIView *)topView {
    if (!_topView) {
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(kZero, kDateTopBtnY, kFullWidth, kDateTopBtnHeight)];
        self.topView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kFullWidth-2*(kDateTopLeftbtnX+kDateTopLeftBtnWidth) , kDateTopBtnHeight)];
        _titleLabel.text = @"";
        _titleLabel.textAlignment =NSTextAlignmentCenter ;
        _titleLabel.textColor =[UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.center = CGPointMake(_topView.frame.size.width/2, kDateTopBtnHeight/2);
        
        [self.topView addSubview: _titleLabel];
    }
    return _topView;
}


@end

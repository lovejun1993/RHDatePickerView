//
//  RHDatePickerView.m
//  RHDatePickerView
//
//  Created by Rhino on 2017/1/13.
//  Copyright © 2017年 Rhino. All rights reserved.
//
#define HOURARRAY @[@"0点", @"1点", @"2点", @"3点", @"4点", @"5点", @"6点", @"7点", @"8点", @"9点", @"10点", @"11点", @"12点", @"13点", @"14点", @"15点", @"16点", @"17点", @"18点", @"19点", @"20点", @"21点", @"22点", @"23点"]
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]  

#import "RHDatePickerView.h"

@interface RHDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong)  UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *minutes;


@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *showDayArray;
@property (nonatomic, strong) NSArray *hourArray;
@property (nonatomic, strong) NSArray *minuteArray;
@property (nonatomic, strong) NSArray *totalArray;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) NSInteger columnIndex;
@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic) int currIndex;

//@property (nonatomic, copy) CompleteBolck completeBlock;
@property (nonatomic, copy) NSString *deadLine;

@end

@implementation RHDatePickerView



//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 3;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    switch (component) {
//        case 0:
//            return self.showDayArray.count;
//        case 1:
//            return self.hourArray.count;
//        case 2:
//            return self.minuteArray.count;
//        default:
//            return 0;
//    }
//}
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    int firstComponentSelectedRow = [self.pickerView selectedRowInComponent:0];
//    if (firstComponentSelectedRow == 0) {
//        _hourArray = [self validHourArray];
//        _minuteArray = [self validMinuteArray];
//        int secondComponentSelectedRow = [self.pickerView selectedRowInComponent:1];
//        if (secondComponentSelectedRow == 0 || component ==0) {
//            _minuteArray = [self validMinuteArray];
//        }else{
//            _minuteArray = self.minutes;
//        }
//    }else{
//        _hourArray = HOURARRAY;
//        _minuteArray = self.minutes;
//    }
//    [self.pickerView reloadAllComponents];
//    
//    //当第一列滑到第一个位置时，第二，三列滚回到0位置
//    if(component == 0){
//        [self.pickerView selectRow:0 inComponent:1 animated:YES];
//        [self.pickerView selectRow:0 inComponent:2 animated:YES];
//    }
//}
//
//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel *label;
//    if (view) {
//        label = (UILabel *)view;
//    }else{
//        label = [[UILabel alloc] init];
//    }
//    label.textAlignment = NSTextAlignmentCenter;
//    switch (component) {
//        case 0:
//            label.text = self.showDayArray[row];
//            //            [label setBackgroundColor:[UIColor redColor]];
//            break;
//        case 1:
//            label.text = self.hourArray[row];
//            //            [label setBackgroundColor:[UIColor greenColor]];
//            break;
//        case 2:
//            label.text = self.minuteArray[row];
//            //            [label setBackgroundColor:[UIColor lightGrayColor]];
//            break;
//        default:
//            break;
//    }
//    
//    return label;
//}
//
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    return self.frame.size.width / 3.0;
//}
//-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 44;
//}



@end

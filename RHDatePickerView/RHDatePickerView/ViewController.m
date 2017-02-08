//
//  ViewController.m
//  RHDatePickerView
//
//  Created by Rhino on 2017/1/13.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "MBDatePickerView.h"
#import "NSDate+YYAdd.h"
//屏幕宽度
#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<MBDatePickerViewDelegate>
@property (nonatomic,strong)MBDatePickerView *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.picker =  [[MBDatePickerView alloc]initWithFrame:self.view.bounds maxDate:[NSDate date] minDate:[[NSDate date] dateByAddingDays:30]];
    self.picker.delegate = self;
    [_picker show];
    NSLog(@"----%ld-----%ld------%ld",[NSDate date].year,[NSDate date].month,[NSDate date].day);
    NSLog(@"----%ld-----%ld------%ld",[[NSDate date] dateByAddingDays:30].year,[[NSDate date] dateByAddingDays:30].month,[[NSDate date] dateByAddingDays:30].day);
    
}

- (void)determine:(NSDate *)date picker:(MBDatePickerView *)picker{
    NSLog(@"-----%@------",date);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

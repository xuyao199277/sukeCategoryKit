//
//  DatePickerView.m
//  Text
//
//  Created by ruiyi on 16/12/8.
//  Copyright © 2016年 ruiyi. All rights reserved.
//

#import "DatePickerView.h"

#define kSupViewHeight  ([UIScreen mainScreen].bounds.size.height / 2.3)

@interface DatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>{

    NSArray *hourAry;
    NSArray *minuteAry;
    UIView *supView;

}

@property (nonatomic ,copy)NSString *selectDateStr;//选中的日期字符串


@end

@implementation DatePickerView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _createChildViews];
   
    }

    return self;
}

- (void)_createChildViews{

        self.frame = [UIScreen mainScreen].bounds;
//    self.height = self.height;
    self.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:0.3/1.0];
    hourAry = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    
    minuteAry = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    self.selectDateStr = dateStr;
    NSString *hourStr = [dateStr substringWithRange:NSMakeRange(11, 2)];
    NSString *minuteStr =[dateStr substringFromIndex:14];
    NSInteger hourIndex = [hourAry indexOfObject:hourStr];
    NSInteger minuteIndex = [minuteAry indexOfObject:minuteStr];
    
    supView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom, [UIScreen mainScreen].bounds.size.width, kSupViewHeight)];
    supView.backgroundColor = [UIColor whiteColor];
    [self addSubview:supView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(20, 10, 35, 25);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:7/255.0 green:134/255.0 blue:231/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self
                  action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [supView addSubview:cancelBtn];

    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    doneBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 35 - 25, 10, 35, 25);
    doneBtn.backgroundColor = [UIColor clearColor];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithRed:7/255.0 green:134/255.0 blue:231/255.0 alpha:1] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneBtn addTarget:self
                  action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [supView addSubview:doneBtn];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 + 25 +10, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:228/255.0 green:231/255.0 blue:240/255.0 alpha:1];
    [supView addSubview:lineView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,10 + 25 +10 + 1,[UIScreen mainScreen].bounds.size.width,kSupViewHeight - 46)];
    pickerView.backgroundColor = [UIColor clearColor];
    //设置代理
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    //指定选中某个单元格
    [pickerView selectRow:(13684 / 2 - 2 + hourIndex) inComponent:1 animated:YES];
    [pickerView selectRow:(13684 / 2 - 2 + minuteIndex) inComponent:2 animated:YES];
    
    [supView addSubview:pickerView];

}

- (void)showOnView:(UIView *)superView{
    [superView addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        if ([self.type isEqualToString:@"160"]) {
              supView.frame = CGRectMake(0, self.bottom - 550, [UIScreen mainScreen].bounds.size.width, 550);
        }else {
            supView.frame = CGRectMake(0, self.bottom - kSupViewHeight, [UIScreen mainScreen].bounds.size.width, kSupViewHeight);
        }
        
    }];
}

#pragma mark - UIPickerView 协议方法

//设置有几列单元格
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

//设置每列单元格的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return 16384;

}

//设置每个单元格显示的内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
 
        NSString *timeStr = [self afterDateStr:[self strFromDate:[NSDate date]] dayCount:row];
        return timeStr;
    }else if (component == 1) {
        
        return hourAry[row%24];
    }else{
        
        return minuteAry[row%60];
    }
}

//设置单元格宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
   
    if (component == 0) {
      
        return 150;
 
    }else{
    
        return 60;
    }
}
//设置单元格高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
}

//单元格选中事件
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    NSInteger dateRow =   [pickerView selectedRowInComponent:0];
    NSInteger hourRow = [pickerView selectedRowInComponent:1];
    NSInteger minuteRow = [pickerView selectedRowInComponent:2];
    
    self.selectDateStr = [NSString stringWithFormat:@"%@ %@:%@",[self afterDateStr:[self strFromDate:[NSDate date]] dayCount:dateRow],hourAry[hourRow%24],minuteAry[minuteRow%60]];;
    
}

#pragma mark - 触摸手势

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self cancelClick];
    }
}

#pragma mark - 按钮点击

- (void)cancelClick{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        supView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kSupViewHeight);
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.35 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         [self removeFromSuperview];
    });
}

- (void)doneClick{

    [self cancelClick];
    
    if (self.delegate) {
        [self.delegate doneClick:self.selectDateStr];
    }
    
}

#pragma mark - 日期相关
//日期转字符串
- (NSString *)strFromDate:(NSDate *)date{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;

}

//根据字符串 和 天数距离 求出日期字符串
-(NSString *)afterDateStr:(NSString *)str
                 dayCount:(NSInteger) count{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:str];
    
    NSTimeInterval interval = [date timeIntervalSince1970];

    NSDate *afterDate = [NSDate dateWithTimeIntervalSince1970:(interval + count * 24 * 60 * 60)];
    
    return [self strFromDate:afterDate];
    
}

@end

//
//  DatePickerView.h
//  Text
//
//  Created by ruiyi on 16/12/8.
//  Copyright © 2016年 ruiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)doneClick:(NSString *)dateStr;

@end

@interface DatePickerView : UIView

@property (nonatomic,assign) id<DatePickerViewDelegate>delegate;
@property(nonatomic,copy)NSString *type;
//显示
- (void)showOnView:(UIView *)supView;


@end

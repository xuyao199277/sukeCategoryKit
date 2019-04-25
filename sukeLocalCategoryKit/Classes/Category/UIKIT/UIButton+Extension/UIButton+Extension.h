//
//  UIButton+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

-(dispatch_source_t )startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle finished:(void(^)(UIButton *button))finished;
-(void)cancelTimer:(dispatch_source_t)timer;

/**
 *  手机倒计时
 *
 *  @param timeLine 持续时间
 *  @param title    开始标题
 *  @param subTitle 过程标题
 *  @param mColor   开始颜色
 *  @param color    过程颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

-(UIImageView *)addImg:(UIImage *)img withIMGframe:(CGRect )IMGframe;

-(void)setFrame:(CGRect)frame Title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)fontColor State:(UIControlState)state;

- (instancetype)initXYcustomButtonWithFrame:(CGRect)frame;

/*设置背景颜色生成的图片*/
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

//利用运行时把点击sel修改成block
@property(nonatomic ,copy)void(^touchUpInsideBlock)(UIButton*btn);

-(void)addTouchUpInsideBlock:(void(^)(UIButton*btn))touchUpInsideBlock;
@end

//
//  UIButton+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIButton+Extension.h"
#import<objc/runtime.h>
@interface UIImage (MiddleAligning)

@end

@implementation UIImage (MiddleAligning)

- (UIImage *)MiddleAlignedButtonImageScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end


@implementation UIButton (Extension)
-(dispatch_source_t )startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle finished:(void(^)(UIButton *button))finished
{
    __block NSInteger timeOut = timeout; //The countdown time
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //To perform a second
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //it is time to
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //it is time to  set title
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                finished(self);
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%ld", timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    return _timer;
}
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setAttributedTitle:nil forState:UIControlStateNormal];
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //变颜色
                NSString *all_string = [NSString stringWithFormat:@"%@(%@s)",subTitle,timeStr];
                NSUInteger location = [all_string rangeOfString:@"("].location + 1;
                NSUInteger length = [all_string rangeOfString:@"s)"].location - location;
                NSRange range = NSMakeRange(location, length);
                NSMutableAttributedString *attrString = [self setMutableAttributedStringWithString:all_string color:[UIColor whiteColor] range:NSMakeRange(0, all_string.length) subStrColor:[UIColor orangeColor] subStrRange:range];
                [weakSelf setAttributedTitle:attrString forState:UIControlStateNormal];
                weakSelf.backgroundColor = color;
                weakSelf.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
- (NSMutableAttributedString *)setMutableAttributedStringWithString:(NSString *)string color:(UIColor *)color range:(NSRange)range {
    return [self setMutableAttributedStringWithString:string color:color range:range subStrColor:nil subStrRange:NSMakeRange(0, 0)];
}

- (NSMutableAttributedString *)setMutableAttributedStringWithString:(NSString *)string color:(UIColor *)color range:(NSRange)range subStrColor:(UIColor *)subStrColor subStrRange:(NSRange)subStrRange {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    if (subStrColor != nil && subStrRange.length != 0) {
        [attrString addAttribute:NSForegroundColorAttributeName value:subStrColor range:subStrRange];
    }
    return attrString;
}
-(void)cancelTimer:(dispatch_source_t)timer
{
    if (!timer) return;
    dispatch_source_cancel(timer);
}-(UIImageView *)addImg:(UIImage *)img withIMGframe:(CGRect )IMGframe
{
    UIImageView *img_VC = [[UIImageView alloc]initWithFrame:IMGframe];
    img_VC.image = img;
    img_VC.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:img_VC];
    
    return img_VC;
}
-(void)setFrame:(CGRect)frame Title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)fontColor State:(UIControlState)state
{
    self.frame = frame;
    [self setTitle:title forState:state];
    [self setTitleColor:fontColor forState:state];
    [self.titleLabel setFont:font];
}

- (instancetype)initXYcustomButtonWithFrame:(CGRect)frame
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame=frame;
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=frame.size.height/6;
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        [self setBackgroundColor:kRuida_DarkRedColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//更换点击事件block
-(void)setTouchUpInsideBlock:(void (^)(UIButton *btn))touchUpInsideBlock

{
    objc_setAssociatedObject(self,@selector(touchUpInsideBlock), touchUpInsideBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void(^)(UIButton*))touchUpInsideBlock

{
    return objc_getAssociatedObject(self,@selector(touchUpInsideBlock));
}

-(void)addTouchUpInsideBlock:(void (^)(UIButton *btn))touchUpInsideBlock

{
    
    self.touchUpInsideBlock= touchUpInsideBlock;
    
   [self addTarget: self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton*)btn

{
    if(self.touchUpInsideBlock) {
        self.touchUpInsideBlock(btn);
}
    
}
@end

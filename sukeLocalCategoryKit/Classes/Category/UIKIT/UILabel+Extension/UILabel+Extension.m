//
//  UILabel+Extension.m
//  RidaProperty
//
//  Created by 徐姚 on 2018/1/31.
//  Copyright © 2018年 suke. All rights reserved.
//
//计算高度
//CGSize titleSize = [contentText boundingRectWithSize:CGSizeMake(cell.i_contentLabelText.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.i_contentLabelText.font} context:nil].size;

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    self=[[UILabel alloc] initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.text=text;
        if(textAlignment)self.textAlignment=textAlignment;
        self.font=font;
        self.textColor=textColor;
    }
    return self;
}

@end

//
//  UIColor+GetHexColor.h
//  ZHYQ
//
//  Created by 徐姚 on 2017/5/27.
//  Copyright © 2017年 suke. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  获取不同进制的颜色
 */

@interface UIColor (GetHexColor)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end

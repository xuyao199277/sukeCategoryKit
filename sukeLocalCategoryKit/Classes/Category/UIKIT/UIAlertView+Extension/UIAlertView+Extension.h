//
//  UIAlertView+Extension.h
//  RidaProperty
//
//  Created by 徐姚 on 2018/5/31.
//  Copyright © 2018年 suke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);
@interface UIAlertView (Extension)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end

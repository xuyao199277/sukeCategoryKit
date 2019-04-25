//
//  UIWebView+Extension.h
//  RidaProperty
//
//  Created by 徐姚 on 2018/2/23.
//  Copyright © 2018年 suke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Extension)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect)frame;

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect)frame;

@end

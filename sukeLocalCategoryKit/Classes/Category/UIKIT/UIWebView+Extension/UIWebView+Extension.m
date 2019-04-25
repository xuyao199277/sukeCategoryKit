//
//  UIWebView+Extension.m
//  RidaProperty
//
//  Created by 徐姚 on 2018/2/23.
//  Copyright © 2018年 suke. All rights reserved.
//

#import "UIWebView+Extension.h"

@implementation UIWebView (Extension)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect)frame {
    
    //此处的title设置为nil，URL地址就没了
    
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"提示!" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [customAlert show];
    
    
    
}



static BOOL diagStat = NO;

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect)frame

{
    
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:@"Confirm Title" message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
    
    [confirmDiag show];
    
    while (confirmDiag.hidden == NO && confirmDiag.superview != nil)
        
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    
    return diagStat;
    
}





- (void)alertView:(UIAlertView *)alertView clickeonAtIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex == 0)
        
    {
        
        diagStat = NO;
        
    }
    
    else if (buttonIndex == 1)
        
    {
        
        diagStat = YES;
        
    }
    
}

@end

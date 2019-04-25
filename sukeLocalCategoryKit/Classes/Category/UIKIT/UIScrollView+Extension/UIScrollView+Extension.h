//
//  UIScrollView+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Extension)

#pragma mark - custom refresh
- (void)showRefreshHeader:(void(^)(void))downBlock;

- (void)showRefreshFotter:(void(^)(void))upBlock;

- (void)hiddenRefreshHeader;

- (void)hiddenRefreshFotter;

@end

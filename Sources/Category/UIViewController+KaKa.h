//
//  UIViewController+KaKa.h
//  KaKa
//
//  Created by lihui on 15/5/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (KaKa)

/**
 *  显示导航栏
 */
- (void)showNavBar;

/**
 *  隐藏导航栏
 */
- (void)hiddenNavBar;

/**
 *  显示tabbar
 */
- (void)showTabBar;

/**
 *  隐藏Tabbar
 */
- (void)hiddenTabBar;

/**
 *  设置push后新界面是否隐藏底部栏
 *
 *  @param aStatus YES:隐藏，NO:显示
 */
- (void)hiddenBottomBarWhenPush:(BOOL)aStatus;

@end

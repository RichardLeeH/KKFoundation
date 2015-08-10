//
//  UIViewController+KaKa.m
//  KaKa
//
//  Created by lihui on 15/5/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UIViewController+KaKa.h"

@implementation UIViewController (KaKa)

/**
 *  显示导航栏
 */
- (void)showNavBar
{
    self.navigationController.navigationBar.hidden = NO;
}

/**
 *  隐藏导航栏
 */
- (void)hiddenNavBar
{
    self.navigationController.navigationBar.hidden = YES;
}

/**
 *  显示tabbar
 */
- (void)showTabBar
{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

/**
 *  隐藏Tabbar
 */
- (void)hiddenTabBar
{
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

/**
 *  设置push后新界面是否隐藏底部栏
 *
 *  @param aStatus YES:隐藏，NO:显示
 */
- (void)hiddenBottomBarWhenPush:(BOOL)aStatus
{
    self.hidesBottomBarWhenPushed = aStatus;
}

@end

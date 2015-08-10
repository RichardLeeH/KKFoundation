//
//  KKViewControllerManger.h
//  HiTao
//  本类用于管理系统中，引导页，主页及其他页面的管理，所有页面的跳转通过 委托，在本页面处理，减少页面之间的耦合
//  Created by lihui  on 14/10/31.
//  Copyright (c) 2014年 HiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@protocol KKControllerMangerDelegate <NSObject>

///  @brief  获取主界面
///
///  @return <#return value description#>
- (UIViewController *)mainViewController;

///  @brief  获取引导页面
///
///  @return <#return value description#>
- (UIViewController *)guideViewController;


@end

@interface KKViewControllerManger : NSObject<BaseViewControllerChangeDelegate>

@property (nonatomic, weak)id<KKControllerMangerDelegate> delegate;

@property (strong, nonatomic) UIWindow *window;

/**
 *  获取VCManager管理对象
 *
 *  @return KKViewControllerManger
 */
+(KKViewControllerManger*)sharedVCManager;

/**
 *  显示主界面
 */
-(void)showMainVC;

/**
 *  先是引导页
 */
-(void)showGuideVC;

@end

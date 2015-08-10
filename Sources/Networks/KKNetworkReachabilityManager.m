//
//  KKNetworkReachabilityManager.m
//  HiTao
//  开启关闭网络监控
//  Created by 李辉 on 14/11/6.
//  Copyright (c) 2014年 HiTao. All rights reserved.
//

#import "KKNetworkReachabilityManager.h"
#import "AFNetworking.h"
#import "Utils.h"

@implementation KKNetworkReachabilityManager

//
// Function   : startMonitoring
// Description: 使用afnetworkong 开启网络监控
// Input      :
// Output     :
// Return     :
//
+ (void)startMonitoring
{
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    //当网络状态改变的时候，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
            case AFNetworkReachabilityStatusUnknown://未知网络
            case AFNetworkReachabilityStatusNotReachable://没有网络
            {
                //通知网络中断
                //创建通知
                NSDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:@"NO" forKey:@"netstatus"];
                
                NSNotification *notification =[NSNotification notificationWithName:KKNetChangeNotification object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
            {
                //创建通知
                NSDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:@"YES" forKey:@"netstatus"];
                
                NSNotification *notification =[NSNotification notificationWithName:KKNetChangeNotification object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            break;
            }// end of switch (status)
            }];
    
    //开始监控
    [mgr startMonitoring];
}

//
// Function   : stopMonitoring
// Description: 使用afnetworkong 关闭网络监控
// Input      :
// Output     :
// Return     :
//
+ (void)stopMonitoring
{
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    [mgr stopMonitoring];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (BOOL) netAvailable
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    BOOL ret = mgr.isReachable;
    return ret;
}

+ (NSString *)networkingStatesFromStatebar
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children)
    {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type)
    {
        case 0:
            stateString = @"notReachable";
            break;
        case 1:
            stateString = @"2G";
            break;
        case 2:
            stateString = @"3G";
            break;
        case 3:
            stateString = @"4G";
            break;
        case 4:
            stateString = @"LTE";
            break;
        case 5:
            stateString = @"wifi";
            break;
        default:
            break;
    }
    
    return stateString;
}

@end

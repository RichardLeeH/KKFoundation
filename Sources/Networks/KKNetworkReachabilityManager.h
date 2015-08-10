//
//  KKNetworkReachabilityManager.h
//  HiTao
//  用于开启全局的网络监控，监控网络状态
//  Created by 李辉 on 14/11/6.
//  Copyright (c) 2014年 HiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNetworkReachabilityManager : NSObject

//
// Function   : startMonitoring
// Description: 使用afnetworkong 开启网络监控
// Input      :
// Output     :
// Return     :
//
+ (void)startMonitoring;

//
// Function   : stopMonitoring
// Description: 使用afnetworkong 关闭网络监控
// Input      :
// Output     :
// Return     :
//
+ (void)stopMonitoring;

///网络是否可用
+ (BOOL) netAvailable;

///获取网络类型包括，2G,3G or 4G and so on, 此方法要求状态栏不能隐藏
+ (NSString *)networkingStatesFromStatebar;

@end

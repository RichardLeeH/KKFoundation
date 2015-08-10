//
//  KKNetworkOperation.h
//  KaKa
//
//  Created by 郭 健 on 15/2/14.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface KKNetworkOperation :AFHTTPRequestOperation

@property(nonatomic,assign)id       networkObserver;

/**
 *  返回json 数据
 */
- (id)responseJson;

/**
 *  返回数据字符串
 *
 *  @return
 */
- (id)response2String;

@end

//
//  KKNetworkOperation.m
//  KaKa
//
//  Created by 郭 健 on 15/2/14.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "KKNetworkOperation.h"

@implementation KKNetworkOperation

/**
 *  返回json 数据
 */
- (id)responseJson
{
    return [self responseObject];
}

/**
 *  返回数据字符串
 *
 *  @return
 */
- (id)response2String
{
    return [self responseString];
}

@end

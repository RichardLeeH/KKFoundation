//
//  NSDictionary+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/4/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "NSDictionary+KaKa.h"
#import "NSObject+KaKa.h"
#import "Utils.h"

@implementation NSDictionary(KaKa)

-(NSDictionary*)dictionaryByAddDictionary:(NSDictionary *)dict
{
    if (dict == nil || dict.count == 0) {
        return self;
    }
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithDictionary:self];
    
    for (NSString *key in [dict allKeys]) {
        [ret setObject:[dict objectForKey:key] forKey:key];
    }
    
    return ret;
}

-(NSDictionary*)dictionaryByAddObject:(id)obj
{
    if (obj == nil) {
        return self;
    }
    
    return [self dictionaryByAddDictionary:[obj toDictionary]];
}

+(NSDictionary*)dictionaryWithJsonData:(NSData *)data
{
    if (!data || (NSNull *)data == [NSNull null]) {
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(NSDictionary*)dictionaryWithJsonString:(NSString *)string
{
    if (isBlankString(string)) {
        return nil;
    }
    
    return [NSDictionary dictionaryWithJsonData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

@end

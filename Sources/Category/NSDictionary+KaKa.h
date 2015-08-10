//
//  NSDictionary+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/4/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(KaKa)

-(NSDictionary*)dictionaryByAddDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryByAddObject:(id)obj;
+(NSDictionary*)dictionaryWithJsonData:(NSData*)data;
+(NSDictionary*)dictionaryWithJsonString:(NSString*)string;
@end

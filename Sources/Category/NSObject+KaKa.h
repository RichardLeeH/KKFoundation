//
//  NSObject+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/3/24.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface NSObject (KaKa)
//对象生成字典
-(NSDictionary*)toDictionary;

//字典生成对象
-(NSObject*)toObject:(NSDictionary *)dic;

-(id)toObjectFromRS:(FMResultSet*)rs;

+(id)kkObjectWithString:(NSString*)s;

+(NSString*)kkStringWithObject:(NSObject*)obj;


@end

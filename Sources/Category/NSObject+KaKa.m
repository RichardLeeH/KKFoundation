//
//  NSObject+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/3/24.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "NSObject+KaKa.h"
#import <objc/message.h>
#import "Utils.h"

@implementation NSObject(KaKa)
- (NSDictionary *)toDictionary
{
    Class className = [self class];
    u_int count;
    objc_property_t *properties = class_copyPropertyList(className, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        if (strcmp(propertyName, "sid") == 0) {
            [propertyArray addObject:@"id"];
        }
        else
        {
            [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        }
        
        id value =  [self valueForKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        if ([value isKindOfClass:[NSValue class]]) {
            const char * type=[value objCType];
            NSLog(@"%@", [NSString stringWithCString:type encoding:NSUTF8StringEncoding]);
        }
        
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    return returnDic;
}

-(NSObject *)toObject:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]])
    {
        return self;
    }
    
    Class className = [self class];
    u_int count;
    
    objc_property_t *properties = class_copyPropertyList(className, &count);
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        
        const char* propertyName = property_getName(prop);
        
        if (strcmp(propertyName, "sid") == 0)
        {
            propertyName = "id";
        }
        
        id value =  [dic valueForKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        if ([Utils isBlankObject:value])
        {
            value = @"";
        }
        
        if([value isKindOfClass:[NSNumber class]]){
            value=[(NSNumber*)value stringValue];
        }
        
        if (value) {
            if (strcmp(propertyName, "id") == 0)
            {
                [self setValue:value forKey:@"sid"];
            }
            else
            {
                [self setValue:value forKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
                
            }
        }
    }
    
    free(properties);
    
    return self;
}

-(id)toObjectFromRS:(FMResultSet *)rs
{
    if (!rs) {
        return self;
    }
    
    Class className = [self class];
    u_int count;
    
    objc_property_t *properties = class_copyPropertyList(className, &count);
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        
        const char* propertyName = property_getName(prop);
        
        NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
        if ([propertyNameString rangeOfString:@"obj_"].location != NSNotFound) {
            continue;
        }
        
        if ([propertyNameString isEqualToString:@"sid"]) {
            propertyNameString = @"id";
        }
        
        id value = [rs objectForColumnName:propertyNameString];
        
        if ([Utils isBlankObject:value]) {
            value = @"";
        }
        
        if([value isKindOfClass:[NSNumber class]]){
            value=[(NSNumber*)value stringValue];
        }
        
        if (value) {
            if ([propertyNameString isEqualToString:@"id"])
            {
                [self setValue:value forKey:@"sid"];
            }
            else
            {
                [self setValue:value forKey:propertyNameString];
            }
        }
    }
    
    free(properties);
    
    return self;
}

+(id)kkObjectWithString:(NSString *)s
{
    if (!s || (NSNull *)s == [NSNull null] || [s isEqual:@""]) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}

+(NSString *)kkStringWithObject:(NSObject *)obj
{
    if (!obj || (NSNull *)obj == [NSNull null] || [obj isEqual:@""]) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

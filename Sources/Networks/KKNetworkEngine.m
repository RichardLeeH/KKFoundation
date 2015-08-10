//
//  KKNetworkEngine.m
//  KaKa
//
//  Created by 郭 健 on 15/3/23.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "KKNetworkEngine.h"
#import "KKNetworkOperation.h"
#import "Utils.h"
#import "NSDictionary+RequestEncoding.h"
#define kVersion            @"V2.0"
#import "GCDObjC.h"

@interface KKNetworkEngine()
{
    AFSecurityPolicy *_securityPolicy;
    NSURL            *_baseUrl;
}

@end

@implementation KKNetworkEngine

- (id)initWithBaseUrl:(NSString *)aUrl
{
    self = [super init];
    if (nil != self)
    {
        _securityPolicy = [[AFSecurityPolicy alloc] init];
        [_securityPolicy setAllowInvalidCertificates:YES];
         _baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", aUrl, kVersion]];
    }
    
    return self;
}

+(id)sharedInstance
{
    GCDSharedInstance((^
    {
        KKNetworkEngine *ret = [[KKNetworkEngine alloc] init];
        
        //添加返回数据类型
        
        return ret;
    }));
}

+(NSDictionary*)getSysData
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    return ret;
}

/**
 *  发送网络请求
 *
 *  @param aPath    请求URL
 *  @param aBody    传递参数
 *  @param aMethod  请求方式：GET OR POST
 *  @param aSuccess 成功返回
 *  @param aError   失败返回
 *
 *  @return KKNetworkOperation
 */
- (KKNetworkOperation*)commonRequest:(NSString *)aPath
                              params:(NSDictionary *)aBody
                          httpMethod:(NSString*)aMethod
                             handler:(KKResponseBlock)aSuccess
                        errorHandler:(KKResponseErrorBlock)aError;
{

    KKNetworkOperation *operation = nil;
    
    NSDictionary *params = @{@"sysData":[[KKNetworkEngine getSysData] jsonEncodedKeyValueString],
                             @"data":[aBody jsonEncodedKeyValueString]};
    NSLog(@"---------------------\n\
          %@/%@?%@\n\
          -----------------------", _baseUrl, aPath, params);

    AFHTTPRequestOperationManager *mrg = [[AFHTTPRequestOperationManager manager] initWithBaseURL:_baseUrl];
    
    mrg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    mrg.securityPolicy = _securityPolicy;

    if ([[aMethod uppercaseString] isEqualToString:@"GET"])
    {
        operation = (KKNetworkOperation* )[mrg GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if (aSuccess)
            {
                aSuccess(operation, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            if (aError)
            {
                aError(operation, error);
            }
        }];
    }
    else if ([[aMethod uppercaseString] isEqualToString:@"POST"])
    {
        operation = (KKNetworkOperation *)[mrg POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if (aSuccess)
             {
                 NSLog(@"返回成功的数据=%@", responseObject);
                 aSuccess(operation, responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             if (aError)
             {
                 NSLog(@"返回失败的信息的数据=%@", error);

                 aError(operation, error);
             }
         }];
    }
    
    return operation;
}

/**
 *  发送POST请求
 *
 *  @param aPath    请求URL
 *  @param aBody    传递参数
 *  @param aSuccess 成功返回
 *  @param aError   失败返回
 *
 *  @return KKNetworkOperation
 */
- (KKNetworkOperation*)commonPostRequest:(NSString *)aPath
                                  params:(NSDictionary *)aBody
                                 handler:(KKResponseBlock)aSuccess
                            errorHandler:(KKResponseErrorBlock)aError
{
    return [self commonRequest:aPath
                        params:aBody
                    httpMethod:@"POST"
                       handler:aSuccess
                  errorHandler:aError];
}

/**
 *  发送GET请求
 *
 *  @param aPath    请求URL
 *  @param aBody    传递参数
 *  @param aSuccess 成功返回
 *  @param aError   失败返回
 *
 *  @return KKNetworkOperation
 */
- (KKNetworkOperation*)commonGetRequest:(NSString *)aPath
                                 params:(NSDictionary *)aBody
                                handler:(KKResponseBlock)aSuccess
                           errorHandler:(KKResponseErrorBlock)aError
{
    return [self commonRequest:aPath
                        params:aBody
                    httpMethod:@"GET"
                       handler:aSuccess
                  errorHandler:aError];
}

/**
 *  上传图片
 *
 *  @param aPath     请求URL
 *  @param aFilePath 图片文件路径
 *  @param aFilename 图片文件名称
 *  @param aBody     请求参数
 *  @param aSuccess  成功返回
 *  @param aError    失败返回
 *
 *  @return KKNetworkOperation
 */
- (KKNetworkOperation*)commomUpdatePicRequest:(NSString *)aPath
                                         File:(NSData*)aFilePath
                                     FileName:(NSString*)aFilename
                                       params:(NSDictionary *)aBody
                                      handler:(KKResponseBlock)aSuccess
                                 errorHandler:(KKResponseErrorBlock)aError
{
    NSDictionary *params = @{@"sysData":[[KKNetworkEngine getSysData] jsonEncodedKeyValueString],
                             @"data":[aBody jsonEncodedKeyValueString]};
    NSLog(@"---------------------\n\
          %@/%@?%@\n\
          -----------------------", _baseUrl, aPath, params);
    AFHTTPRequestOperationManager *mrg = [[AFHTTPRequestOperationManager manager] initWithBaseURL:_baseUrl];
    
    mrg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    mrg.securityPolicy = _securityPolicy;

    [mrg.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    KKNetworkOperation *ret = (KKNetworkOperation *)[mrg POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {//表单拼接数据
         //拼接头像文件信息
     }
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {//成功情况
         if (aSuccess)
         {
             NSLog(@"返回成功的数据 = %@", responseObject);
             aSuccess(operation, responseObject);
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {//失败情况
         if (aError)
         {
             NSLog(@"ERROR = %@", aError);
             aError(operation, error);
         }
     }];

    return ret;
}

/**
 *  上传图片
 *
 *  @param aPath     请求URL
 *  @param aFilePath 图片文件路径
 *  @param aFilename 图片文件名称
 *  @param aBody     请求参数
 *  @param aSuccess  成功返回
 *  @param aError    失败返回
 *
 *  @return KKNetworkOperation
 */
- (KKNetworkOperation*)commomUpdateMultyPicRequest:(NSString *)aPath
                                              File:(NSArray*)aFilePath
                                          FileName:(NSString*)aFilename
                                            params:(NSDictionary *)aBody
                                           handler:(KKResponseBlock)aSuccess
                                      errorHandler:(KKResponseErrorBlock)aError
{
    
    NSDictionary *params = @{@"sysData":[[KKNetworkEngine getSysData] jsonEncodedKeyValueString],
                             @"data":[aBody jsonEncodedKeyValueString]};
    NSLog(@"---------------------\n\
          %@/%@?%@\n\
          -----------------------", _baseUrl, aPath, params);
    AFHTTPRequestOperationManager *mrg = [[AFHTTPRequestOperationManager manager] initWithBaseURL:_baseUrl];
    
    mrg.securityPolicy = _securityPolicy;

    mrg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [mrg.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    KKNetworkOperation *ret = (KKNetworkOperation *)[mrg POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {//表单拼接数据
        if (!isBlankObject(aFilePath))
        {
            for (NSData* data in aFilePath)
            {
            }
        }
        else
        {
            NSData *data = [NSData dataWithBytes:@"" length:0];
            [formData appendPartWithFileData:data name:aFilename fileName:@"" mimeType:@"application/octet-stream"];
        }
    }
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {//成功情况
                                   if (aSuccess)
                                   {
                                       NSLog(@"返回成功的数据 = %@", responseObject);
                                       aSuccess(operation, responseObject);
                                   }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {//失败情况
                                   if (aError)
                                   {
                                       NSLog(@"ERROR = %@", aError);
                                       aError(operation, error);
                                   }
    }];
    
    return ret;
}

@end

//
//  KKNetworkEngine.h
//  KaKa
//
//  Created by 郭 健 on 15/3/23.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "KKNetworkOperation.h"

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"


//返回成功时
typedef void (^KKResponseBlock)(id aCompletedOperation, NSDictionary *aResopnseJSON);

//返回失败时
typedef void (^KKResponseErrorBlock)(id aCompletedOperation, NSError* aError);

@interface KKNetworkEngine :NSObject

+(id)sharedInstance;

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
                            errorHandler:(KKResponseErrorBlock)aError;

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
                           errorHandler:(KKResponseErrorBlock)aError;

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
                                 errorHandler:(KKResponseErrorBlock)aError;

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
                                      errorHandler:(KKResponseErrorBlock)aError;


@end

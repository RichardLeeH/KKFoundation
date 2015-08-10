//
//  KKWebViewController.h
//  KaKa
//
//  Created by lihui on 15/5/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//  webView h5交互

#import "BaseViewController.h"

@interface KKBaseWebViewController : KBaseViewController

@property (nonatomic, strong) UIWebView    *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSString     *requestUrl;

/**
 *  开始加载h5页面
 */
- (void)startLoad;

/**
 *  停止加载h5页面
 */
- (void)stopLoad;

@end

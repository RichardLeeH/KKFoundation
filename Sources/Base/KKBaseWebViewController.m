//
//  KKWebViewController.m
//  KaKa
//
//  Created by lihui on 15/5/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//  webView h5交互

#import "KKBaseWebViewController.h"
#import "Utils.h"
#import "Masonry.h"

@implementation KKBaseWebViewController

//?////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 生命周期函数
- (void)dealloc
{
    [self stopLoad];
    self.webView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildControl];
    [self configControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)aAnimated
{
    [super viewWillAppear:aAnimated];
}

//?////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - BaseInitControlDelegate
-(void)buildControl
{
    if(!_webView)
    {
        WS(weakSelf);
        _webView = [[UIWebView alloc] init];
        
        _webView.scalesPageToFit = YES;
    }
}

-(void)configControl
{
}

//?/////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)startLoad
{
    [self show:nil];
}

- (void)stopLoad
{
    [self.webView stopLoading];
}

@end

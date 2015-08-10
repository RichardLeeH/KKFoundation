//
//  KKNoNetView.h
//  网络监控
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+KaKa.h"
#import "UIImageView+KaKa.h"
#import "UIView+KaKa.h"
#import "UIButton+KaKa.h"
#import "NSTimer+KaKa.h"
#import "NSObject+KaKa.h"
#import "UITextField+KaKa.h"
#import "Utils.h"

@protocol KKNoNetViewDelegate <NSObject>

@optional
- (void)refresh;

@end

//用于刷新界面
typedef void (^kkRefreshBlock)();

@interface KKNoNetView : UIView

@property(nonatomic, weak)id<KKNoNetViewDelegate> delegate;

@property(nonatomic, copy)kkRefreshBlock refreshBlock;

+ (KKNoNetView *)sharedView;

+ (void)showWithView:(UIView *)aSuperview withDelegate:(id<KKNoNetViewDelegate>)aDelegate;

+ (void)dismiss;

@end

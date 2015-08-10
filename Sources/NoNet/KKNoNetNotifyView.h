//
//  KKNoNetNotifyView.h
//  KKNoNetNotifyView
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"
#import "UIImage+KaKa.h"
#import "UIImageView+KaKa.h"
#import "UIView+KaKa.h"
#import "UIButton+KaKa.h"
#import "NSTimer+KaKa.h"
#import "NSObject+KaKa.h"
#import "UITextField+KaKa.h"
#import "Utils.h"

@interface KKNoNetNotifyView : UIControl

+ (KKNoNetNotifyView *)sharedView;
+ (void)showWithView:(UIView *)aSuperview;
+ (void)dismiss;

@end

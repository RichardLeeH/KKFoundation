//
//  KKNoNetNotifyView.m
//  KKNoNetNotifyView
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.//

#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "KKNoNetNotifyView.h"

#import "Masonry.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define KK_NO_NET_PROMPT_TIP_IMAGE   @"network_icon"
#define KK_NO_NET_ARROW_PROMPT_IMAGE @"network_prompt_arrow"
#define KK_NO_NET_PROMPT_BG_IMAGE    @"network_prompt_background"

#define kMargin   adapt1242(50)
#define kTextFont                   adapt1242(50)
#define kNavMarginX         adapt2208(60)

typedef NS_ENUM(NSUInteger, KKNoNetNotifyState)
{
    KKStateShowed,
    KKStateDismissed
};

@interface KKNoNetNotifyView()

@property (nonatomic, assign)KKNoNetNotifyState noNetNotifyState;
@end

@implementation KKNoNetNotifyView

+ (KKNoNetNotifyView *)sharedView
{
    static KKNoNetNotifyView *sharedView = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedView = [[KKNoNetNotifyView alloc] init];
        sharedView.noNetNotifyState = KKStateDismissed;
    });
    
    return sharedView;
}

+ (void)showWithView:(UIView *)aSuperview
{
    if ([self sharedView].noNetNotifyState == KKStateDismissed)
    {
        [aSuperview.superview addSubview:[self sharedView]];
        [[KKNoNetNotifyView sharedView] makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aSuperview.top);
            make.size.equalTo([KKNoNetNotifyView sharedView].kkSize);
        }];

        [self sharedView].noNetNotifyState = KKStateShowed;
    }
}

+ (void)dismiss
{
    if ([self sharedView].noNetNotifyState != KKStateDismissed)
    {
        [self sharedView].noNetNotifyState = KKStateDismissed;
        [[self sharedView] removeFromSuperview];
    }
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self buildControl];
        [self configControl];
    }
    
    return self;
}

- (void)buildControl
{
    
}

- (void)configControl
{
    //背景图片
    UIImage *bgImg = kkImageNamed(KK_NO_NET_PROMPT_BG_IMAGE);
    UIImageView *bImg = [UIImageView new];
    bImg.image = bgImg;
    
    [self addSubview:bImg];
    
    self.kkSize = CGSizeMake(KKSCREEN_WIDTH, bgImg.size.height);
    
    //tip image
    UIImageView *tipImg = [UIImageView new];
    tipImg.image = kkImageNamed(KK_NO_NET_PROMPT_TIP_IMAGE);
    
    //tip string
    UILabel *tip = [UILabel new];
    tip.text = KKLocalString(@"KK_NO_NET_PROMPT_TIP");
    tip.textColor = [UIColor whiteColor];
//    tip.font = kkFontWithSize(kTextFont);
    tip.textAlignment = NSTextAlignmentCenter;
    
    //arrow image
    UIImageView *arrowImg = [UIImageView new];
    arrowImg.image = kkImageNamed(KK_NO_NET_ARROW_PROMPT_IMAGE);
    
    //
    [self addSubview:tipImg];
    [self addSubview:tip];
    [self addSubview:arrowImg];

    //layout
    WS(weakSelf);
    
    [bImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.size.equalTo(weakSelf.kkSize);
    }];
    
    [tipImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bImg.left).offset(kMargin);
        make.centerY.equalTo(bImg.centerY);
        make.width.equalTo(tipImg.image.size.width);
    }];
    
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipImg.right);
        make.centerY.equalTo(bImg.centerY);
        make.right.equalTo(bImg.right).offset(-(arrowImg.image.size.width+kMargin));
    }];

    [arrowImg makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bImg.right).offset(-kMargin);
        make.centerY.equalTo(bImg.centerY);
        make.width.equalTo(arrowImg.image.size.width);
    }];
}

@end

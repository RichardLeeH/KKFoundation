//
//  KKNoNetView.m
//  网络监控
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "KKNoNetView.h"
#import "KKControlBuildFactory.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#define kTextFont                   adapt1242(55)
#define KTextFont1                  adapt1242(45)
#define kBrandSize      CGSizeMake(adapt2208(425), adapt2208(100))
#define kNavMarginX         adapt2208(60)

typedef NS_ENUM(NSUInteger, KKNoNetState)
{
    KKStateShowed,
    KKStateDismissed
};

@interface KKNoNetView()

@property (nonatomic, weak) UIButton    *refreshbtn;
@property (nonatomic, assign)KKNoNetState noNetState;
@end

@implementation KKNoNetView

+ (KKNoNetView *)sharedView
{
    static KKNoNetView *sharedView = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedView = [[KKNoNetView alloc] init];
        sharedView.noNetState = KKStateDismissed;
    });
    
    return sharedView;
}

+ (void)showWithView:(UIView *)aSuperview withDelegate:(id<KKNoNetViewDelegate>)aDelegate
{
    if ([self sharedView].noNetState == KKStateDismissed)
    {
        [aSuperview.superview addSubview:[self sharedView]];
        [[KKNoNetView sharedView] makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aSuperview.top);
            make.bottom.equalTo(aSuperview.bottom);
            make.centerX.equalTo(aSuperview.centerX);
            make.size.equalTo(aSuperview);
        }];

        [self sharedView].delegate = aDelegate;
        
        [self sharedView].noNetState = KKStateShowed;
    }
}

+ (void)dismiss
{
    if ([self sharedView].noNetState != KKStateDismissed)
    {
        [self sharedView].refreshBlock = nil;
        [self sharedView].noNetState = KKStateDismissed;
        [[self sharedView] removeFromSuperview];
    }
}

- (instancetype)init
{
    if (self = [super init])
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
    //图标
    UIImageView *logo = [[UIImageView alloc] initWithImage:kkImageNamed(@"networkRequestFail")];
    
    //
    UILabel *tip1 = [KKControlBuildFactory createLabelWithFont:kkFontWithSize(kTextFont) text:KKLocalString(@"KK_NO_NET_TIP1") textColor:[UIColor blackColor]];
    
    //
    UILabel *tip2 = [KKControlBuildFactory createLabelWithFont:kkFontWithSize(KTextFont1) text:KKLocalString(@"KK_NO_NET_TIP2") textColor:[UIColor grayColor]];

    //
    UILabel *tip3 = [KKControlBuildFactory createLabelWithFont:kkFontWithSize(KTextFont1) text:KKLocalString(@"KK_NO_NET_TIP3") textColor:[UIColor grayColor]];

    //refresh butoton
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.backgroundColor = [UIColor clearColor];
    refreshBtn.titleLabel.font = kkFontWithSize(16);
    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refreshBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    refreshBtn.kkSize = kBrandSize;
    refreshBtn.layer.borderColor = [UIColor blackColor].CGColor;
    refreshBtn.layer.borderWidth = 1;
    refreshBtn.layer.cornerRadius = 5;
    refreshBtn.layer.masksToBounds = YES;
    [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    [self addSubview:logo];
    [self addSubview:tip1];
    [self addSubview:tip2];
    [self addSubview:tip3];
    [self addSubview:refreshBtn];

    {
        WS(weakSelf);
                
        [logo makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.centerX);
            make.bottom.equalTo(weakSelf.centerY).offset(-logo.image.size.height/4);
        }];
        
        [tip1 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.centerX);
            make.top.equalTo(weakSelf.centerY);
        }];
        
        [tip2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.centerX);
            make.top.equalTo(tip1.bottom);
        }];
        [tip3 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.centerX);
            make.top.equalTo(tip2.bottom);
        }];
        
        [refreshBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(adapt736(150));
            make.height.equalTo(adapt736(40));
            make.centerX.equalTo(weakSelf.centerX);
            make.top.equalTo(tip3.bottom).offset(10);
        }];
    }
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)refreshClick:(id)aSender
{
//    if (nil != self.refreshBlock)
//    {
//        self.refreshBlock();
//    }
    
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(refresh)])
    {
        [self.delegate refresh];
    }
}

@end

//
//  uniTMBaseVC.m
//  QMall
//
//  Created by zhaoxiaoqiang on 14-4-22.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import "Utils.h"

#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#import "UIViewController+KaKa.h"
#import "BaseViewController.h"
#import "ProgressHUD.h"
#import "UIView+Toast.h"
#import "UIButton+KaKa.h"
#import "KKNoNetView.h"
#import "KKNoDataBaseView.h"
#import "KKNoNetNotifyView.h"
#import "KKNetworkReachabilityManager.h"
#import "KKControlBuildFactory.h"
#import "UIButton+TouchAreaInsets.h"

#define HOME_ICO @"back_ico"

#define kNavTitleFont       adapt2208(70)
#define kNavMarginX         adapt2208(60)
#define kBtnFontHeight      adapt2208(60)

#define kNavBtnInsets       UIEdgeInsetsMake(20, 20, 20, 120)


#define kTitleViewTag       100
#define kLeftViewTag        100
#define kRightViewTag       100

@implementation KKNavigationViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

-(UIViewController*)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

-(UIViewController*)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}

@end

@interface BaseViewController ()<KKNoNetViewDelegate>
{
    KKNoDataBaseView *_noDataView;
}

@property(nonatomic,strong) UITextField * gPhoneTF;
@property(nonatomic,strong) UITextField * gCodeTF;
@property(nonatomic,strong) UIButton    * doneButton;
@property(nonatomic,strong) UIView      * titleContainerView;
@property(nonatomic,strong) UIView      * leftContainerView;
@property(nonatomic,strong) UIView      * rightContainerView;

@end

@implementation BaseViewController

- (void)dealloc
{
    [self dismiss];
}

- (instancetype)initWithDelegate:(id<BaseViewControllerChangeDelegate>)aDelegate
                           paras:(NSDictionary *)aParas
{
    self = [super init];
    if (self)
    {
        self.isShowNoNetNotifyView = YES;
        self.isShowNoNetView       = NO;
        
        self.delegate = aDelegate;
        self.paras    = aParas;
        
        [self setValuesForKeysWithDictionary:aParas];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.navBar             = [UIView new];
    self.contentView        = [UIView new];
    self.titleContainerView = [UIView new];
    self.leftContainerView  = [UIView new];
    self.rightContainerView = [UIView new];
    
    [self.view     addSubview : _navBar];
    [self.view     addSubview : _contentView];
    [self.navBar   addSubview : self.titleContainerView];
    [self.navBar   addSubview : self.leftContainerView];
    [self.navBar   addSubview : self.rightContainerView];
    
    
    WS(weakSelf);
    
    [self.navBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(NAV_BAR_HEIGHT);
    }];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(_navBar.bottom);
        make.bottom.equalTo(weakSelf.view);
    }];
    self.contentView.frame = CGRectMake(0, NAV_BAR_HEIGHT, self.view.kkWidth, self.view.kkHeight - NAV_BAR_HEIGHT);
    
    [self.leftContainerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBar).offset(kNavMarginX);
        make.top.equalTo(_navBar).offset(STATUS_BAR_HEIGHT);
        make.bottom.equalTo(_navBar);
    }];
    
    [self.rightContainerView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_navBar).offset(-kNavMarginX);
        make.top.equalTo(_navBar).offset(STATUS_BAR_HEIGHT);
        make.bottom.equalTo(_navBar);
    }];
    
    [self.titleContainerView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(KKSCREEN_WIDTH/2);
        make.centerX.equalTo(_navBar);
        make.top.equalTo(_navBar).offset(STATUS_BAR_HEIGHT);
        make.bottom.equalTo(_navBar);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self updateNavBar];
    
    //注册网络状态改变通知
    [self regNetObserver];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //判断是否显示无网络控件
    if (![KKNetworkReachabilityManager netAvailable])
    {
        [self showNoNetView];
        [self showNoNetNotifyView];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //取消网络状态改变通知
    [self unregNetObserver];
    
    //无网络控件取消显示
    [self dismissNoNetNotifyView];
    [self dismissNoNetView];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义返回按钮（使用的LeftBarButton设置）仅在次级菜单中出现
    if (self.navigationController.viewControllers.count > 1)
    {
        [self showBackView];
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBackView
{
    [self setNavLeftBtn:nil withImageName:@"back_ico" withTarget:self withAction:@selector(onBackPressed:)];
}

-(UIView*)titleView
{
    return [self.titleContainerView viewWithTag:kTitleViewTag];
}

-(UIView*)leftView
{
    return [self.leftContainerView viewWithTag:kLeftViewTag];
}

-(UIView*)rightView
{
    return [self.rightContainerView viewWithTag:kRightViewTag];
}

-(NSString *)getNavTitle
{
    UILabel *lbl =(UILabel *)[self titleView];
    NSString *titleStr = nil;
    
    if (lbl && [lbl isKindOfClass:[UILabel class]])
    {
        titleStr = lbl.text;
    }
    
    if (titleStr == nil)
    {
        titleStr = @"";
    }
    return titleStr;
}

-(void)setNavTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    
    
    UILabel *tmpLabel = [KKControlBuildFactory createLabelWithFont:[UIFont boldSystemFontOfSize:kNavTitleFont]
                                                              text:title
                                                         textColor:titleColor ? titleColor : [UIColor whiteColor]];
    [tmpLabel setTextAlignment:NSTextAlignmentCenter];
    [self setNavTitleView:tmpLabel];
}

-(UIButton*)setNavLeftBtn:(NSString *)title withImageName:(NSString *)imageName withTarget:(id)target withAction:(SEL)action
{
    UIButton *tmpBtn = nil;

    if (!isBlankString(imageName))
    {
        tmpBtn = [[UIButton alloc] initWithBgImageName:imageName];
        [tmpBtn setTitle:title forState:UIControlStateNormal];
        [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tmpBtn.titleLabel.font = [UIFont systemFontOfSize:adapt2208(45)];
    }
    else if (title != nil)
    {
        tmpBtn = [[UIButton alloc] initWithTitle:title withFont:[UIFont systemFontOfSize:adapt2208(45)] withColor:[UIColor whiteColor]];
    }
    
    if (tmpBtn == nil) {
        return nil;
    }
    
    tmpBtn.touchAreaInsets = kNavBtnInsets;
    [tmpBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    [self setNavLeftView:tmpBtn];
    
    return tmpBtn;
}

-(UIButton*)setNavRightBtn:(NSString *)title withImageName:(NSString *)imageName withTarget:(id)target withAction:(SEL)action
{
    UIButton *tmpBtn = nil;
    
    if (!isBlankString(imageName))
    {
        tmpBtn = [[UIButton alloc] initWithBgImageName:imageName];
        [tmpBtn setTitle:title forState:UIControlStateNormal];
        [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tmpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:kBtnFontHeight];
    }
    else if (title != nil)
    {
        tmpBtn = [[UIButton alloc] initWithTitle:title withFont:[UIFont boldSystemFontOfSize:kBtnFontHeight] withColor:[UIColor whiteColor]];
    }
    
    if (tmpBtn == nil)
    {
        return nil;
    }
    
    tmpBtn.touchAreaInsets = kNavBtnInsets;
    [tmpBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavRightView:tmpBtn];
    
    return tmpBtn;
}

-(void)setNavTitleView:(UIView *)view
{
    [self.titleContainerView removeAllSubviews];
    
    [self.titleContainerView addSubview:view];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.titleContainerView);
        make.width.equalTo(self.titleContainerView);
    }];
}

-(void)setNavLeftView:(UIView *)view
{
    [self.leftContainerView removeAllSubviews];
    
    [self.leftContainerView addSubview:view];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view.kkSize);
        make.centerY.equalTo(self.leftContainerView);
        make.left.equalTo(self.leftContainerView);
        make.right.equalTo(self.leftContainerView).offset(-kNavBtnInsets.right);
    }];
}

-(void)setNavRightView:(UIView *)view
{
    [self.rightContainerView removeAllSubviews];
    
    [self.rightContainerView addSubview:view];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view.kkSize);
        make.centerY.equalTo(self.rightContainerView);
        make.right.equalTo(self.rightContainerView);
        make.left.equalTo(self.rightContainerView).offset(kNavBtnInsets.right);
    }];
}

-(void)pushViewController:(BaseViewController*)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/**
 *  注册网络状态改变通知
 */
- (void)regNetObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netChanged:) name:KKNetChangeNotification object:nil];
}

/**
 *  取消网络状态改变通知
 */
- (void)unregNetObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:KKNetChangeNotification object:nil];
}

/**
 *  接收到返回的状态改变通知
 *
 *  @param aNotify 通知带回的参数信息
 */
- (void)netChanged:(NSNotification *)aNotify
{
    if (nil != aNotify)
    {
        NSString *status = [aNotify.userInfo valueForKey:@"netstatus"];
        
        if ([status isEqual:@"YES"])
        {//网络存在，隐藏网络提示控件
//            [self dismissNoNetView];
            [self dismissNoNetNotifyView];
        }
        else
        {//网络不存在显示控件，分两种情况，有些界面只需要提示小控件，不需要显示大控件
            [self showNoNetView];
            [self showNoNetNotifyView];
        }
    }
}

-(void)onBackPressed:(id)sender
{
    if (self.popToVc)
    {
        [self.navigationController popToViewController:self.popToVc animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setNavBarHidden:(BOOL)navBarHidden
{
    _navBarHidden = navBarHidden;
    
    [self updateNavBar];
}

-(void)updateNavBar
{
    if (_navBar && _contentView)
    {
        [_navBar updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_navBarHidden ? 0 : NAV_BAR_HEIGHT);
        }];
        
        _contentView.frame = _navBarHidden ? self.view.bounds : CGRectMake(0, NAV_BAR_HEIGHT, self.view.kkWidth, self.view.kkHeight - NAV_BAR_HEIGHT);
    }
}

-(UIViewController*)backViewController
{
    if (self.navigationController && self.navigationController.viewControllers.count >= 2) {
        return [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    }
    
    return nil;
}

//?/////////////////////////////////////////////////////////////////////////////////////////////////////

@end

//?////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 网络等待，成功/失败，等得文字提示
@implementation BaseViewController (KKProgress)

- (void)dismiss
{
    [ProgressHUD dismiss];
}

- (void)show:(NSString *)aMsg
{
    [ProgressHUD show:aMsg];
}

- (void)show:(NSString *)aMsg Interaction:(BOOL)aInteraction
{
    [ProgressHUD show:aMsg Interaction:aInteraction];
}

- (void)showSuccess:(NSString *)aMsg
{
//    [ProgressHUD showSuccess:aMsg];
    [KVNProgress showSuccessWithStatus:aMsg];
}

- (void)showSuccess:(NSString *)aMsg Interaction:(BOOL)aInteraction
{
//    [ProgressHUD showSuccess:aMsg Interaction:aInteraction];
    [KVNProgress showSuccessWithStatus:aMsg];
}

- (void)showSuccess:(NSString *)aMsg completion:(KVNCompletionBlock)aCompletion
{
    [KVNProgress showSuccessWithStatus:aMsg completion:aCompletion];
}

- (void)showError:(NSString *)aMsg
{
//    [ProgressHUD showError:aMsg Interaction:NO];
    [KVNProgress showErrorWithStatus:aMsg];
}

- (void)showError:(NSString *)aMsg Interaction:(BOOL)aInteraction
{
//    [ProgressHUD showError:aMsg Interaction:aInteraction];
    [KVNProgress showErrorWithStatus:aMsg];
}

- (void)showError:(NSString *)aMsg completion:(KVNCompletionBlock)aCompletion
{
    [KVNProgress showErrorWithStatus:aMsg completion:aCompletion];
}

/**
 *  <#Description#>
 *
 *  @param aMsg <#aMsg description#>
 */
- (void)toast:(NSString *)aMsg
{
    [self.view makeToast:aMsg duration:2.0 position:CSToastPositionCenter];
}

//?///////////////////////////////////////////////////////////////////////////////////////
//空数据时控件操作
- (void) showNoDataView
{
    if (nil == _noDataView)
    {
        _noDataView = [self createNoDataView];
    }
}

- (void) dismissNoDataView
{
    if (nil != _noDataView)
    {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

- (KKNoDataBaseView *)createNoDataView
{
    return nil;
}

//?///////////////////////////////////////////////////////////////////////////////////////
//触摸事件，按键事件
- (void)go2NetSettingPage:(id)aSender
{
    [self.delegate pushViewController:self toController:@"KKNetSettingTipViewControlller" paras:nil];
}

//?///////////////////////////////////////////////////////////////////////////////////////
//无网络时控件操作
- (void) showNoNetNotifyView
{
    if (self.isShowNoNetNotifyView)
    {
        [KKNoNetNotifyView showWithView:self.contentView];
        [[KKNoNetNotifyView sharedView] addTarget:self action:@selector(go2NetSettingPage:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) dismissNoNetNotifyView
{
    if (self.isShowNoNetNotifyView)
    {
        [[KKNoNetNotifyView sharedView] removeTarget:self action:@selector(go2NetSettingPage:) forControlEvents:UIControlEventTouchUpInside];
        [KKNoNetNotifyView dismiss];
    }
}

- (void) showNoNetView
{
    if (self.isShowNoNetView)
    {
        [KKNoNetView showWithView:self.contentView withDelegate:self];
    }
}

- (void) dismissNoNetView
{
    if (self.isShowNoNetView)
    {
        [KKNoNetView dismiss];
    }
}

@end

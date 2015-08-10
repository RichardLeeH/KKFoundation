//
//  uniTMBaseVC.h
//  QMall
//
//  Created by zhaoxiaoqiang on 14-4-22.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//
//#import "CSecLoginView.h"
//#import "AFFNumericKeyboard.h"

#import "KKNoDataBaseView.h"
#import "KKNetworkOperation.h"
#import <KVNProgress.h>

#define KBaseViewController BaseViewController<BaseInitControlDelegate>

///用于页面跳转代理 所有的页面跳转都在 BaseViewControllerManger 中统一处理，解耦代码
@protocol BaseViewControllerChangeDelegate <NSObject>

//
// Function   : pushViewController
// Description: push方式跳转页面
// Input      : aPreController    :当前页面
//              aDesControllerName:将要跳转页面名称
//              aParas            :页面跳转是否参数，有参数通过这个字典传递
// Output     :
// Return     : void
//
- (void)pushViewController:(id)aPreController
              toController:(NSString *)aDesControllerName
                     paras:(NSDictionary *)aParas;

//
// Function   : presentModalViewController
// Description: modal方式跳转页面
// Input      : aPreController    ：当前页面
//              aDesControllerName：将要跳转页面名称
//              aWrapNav          ：model出的页面是否需要nav
//              aParas            :页面跳转是否参数，有参数通过这个字典传递
// Output     :
// Return     : void
//
- (void)presentModalViewController:(id)aPreController
                      toController:(NSString *)aDesControllerName
                           withNav:(BOOL)aWrapNav
                             paras:(NSDictionary *)aParas;

@end


@protocol BaseInitControlDelegate<NSObject>

@required
-(void)buildControl;
-(void)configControl;
@end


@interface KKNavigationViewController : UINavigationController

@end

@interface BaseViewController : UIViewController<BaseInitControlDelegate>

///页面跳转代理
@property (nonatomic, weak) id<BaseViewControllerChangeDelegate> delegate;

///传递进入的参数
@property (nonatomic, strong) NSDictionary *paras;

//无网络通知控件是否显示，默认为YES, 如果不想显示，设置为NO
@property(nonatomic, assign) BOOL isShowNoNetNotifyView;

//无网络时控件是否显示，默认为NO, 如果显示，设置为YES
@property(nonatomic, assign) BOOL isShowNoNetView;

@property(nonatomic,strong)UIView               *    navBar;
@property(nonatomic,strong)UIView               *    contentView;
@property(nonatomic, strong)KKNetworkOperation  *    kkopration;
@property(nonatomic)BOOL                             navBarHidden;
@property(nonatomic,weak)UIViewController       *    popToVc;

- (instancetype)initWithDelegate:(id<BaseViewControllerChangeDelegate>)aDelegate
                           paras:(NSDictionary *)aParas;

-(void)setNavTitle:(NSString *)title
        titleColor:(UIColor*)titleColor;
-(UIButton*)setNavLeftBtn:(NSString*)title
            withImageName:(NSString*)imageName
               withTarget:(id)target withAction:(SEL)action;
-(UIButton*)setNavRightBtn:(NSString*)title
             withImageName:(NSString*)imageName
                withTarget:(id)target withAction:(SEL)action;

-(void)setNavTitleView:(UIView*)view;
-(void)setNavLeftView:(UIView*)view;
-(void)setNavRightView:(UIView*)view;

- (NSString *)getNavTitle;

-(void)pushViewController:(BaseViewController*)vc;
-(void)onBackPressed:(id)sender;

-(UIViewController*)backViewController;


//?/////////////////////////////////////////////////////////////////////////////////////////////////////


@end


//?////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 网络等待，成功/失败，等待文字提示
@interface BaseViewController (KKProgress)

/**
 *  停止网络请求等待
 */
- (void)dismiss;

/**
 *  显示网络请求等待，不提示则传入nil
 *
 *  @param aMsg 提示文字
 */
- (void)show:(NSString *)aMsg;

/**
 *  显示网络请求等待，不提示则传入nil
 *
 *  @param aMsg         提示文字
 *  @param aInteraction
 */
- (void)show:(NSString *)aMsg Interaction:(BOOL)aInteraction;

/**
 *  成功信息提示
 *
 *  @param aMsg 提示文字
 */
- (void)showSuccess:(NSString *)aMsg;

/**
 *  成功信息提示
 *
 *  @param aMsg         提示文字
 *  @param aInteraction
 */
- (void)showSuccess:(NSString *)aMsg Interaction:(BOOL)aInteraction;

/**
 *  成功信息提示
 *
 *  @param aMsg        提示文字
 *  @param aCompletion 显示完毕后续处理
 */
- (void)showSuccess:(NSString *)aMsg completion:(KVNCompletionBlock)aCompletion;

/**
 *  失败或者警告信息提示
 *
 *  @param aMsg 提示文字
 */
- (void)showError:(NSString *)aMsg;

/**
 *  失败或者警告信息提示
 *
 *  @param aMsg         提示文字
 *  @param aInteraction
 */
- (void)showError:(NSString *)aMsg Interaction:(BOOL)aInteraction;

/**
 *  失败或者警告信息提示
 *
 *  @param aMsg        提示文字
 *  @param aCompletion 显示完毕后续处理
 */
- (void)showError:(NSString *)aMsg completion:(KVNCompletionBlock)aCompletion;

/**
 *  <#Description#>
 *
 *  @param aMsg <#aMsg description#>
 */
- (void)toast:(NSString *)aMsg;


//?///////////////////////////////////////////////////////////////////////////////////////
//空数据时控件操作
- (void) showNoDataView;
- (void) dismissNoDataView;

/**
 *  需要显示空数据提示的界面必须实现该方法
 *
 *  @return 返回对应的空数据控件。
 */
- (KKNoDataBaseView *)createNoDataView;

//?///////////////////////////////////////////////////////////////////////////////////////
//无网络时控件操作
- (void) showNoNetNotifyView;
- (void) dismissNoNetNotifyView;

- (void) showNoNetView;
- (void) dismissNoNetView;

@end

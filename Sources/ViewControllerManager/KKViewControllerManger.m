//
//  HTViewControllerManger.m
//  HiTao
//  本类用于管理系统中，引导页，主页及其他页面的管理，所有页面的跳转通过 委托，在本页面处理，减少页面之间的耦合
//  Created by lihui  on 14/10/31.
//  Copyright (c) 2014年 HiTao. All rights reserved.
//

#import "KKViewControllerManger.h"
#import "BaseViewController.h"
#import "Utils.h"

@interface KKViewControllerManger ()
@end


static KKViewControllerManger* g_instance = nil;

@implementation KKViewControllerManger

+(KKViewControllerManger*)sharedVCManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] init];
    });
    return g_instance;
}


-(void)showMainVC
{
    self.window.rootViewController = [self.delegate mainViewController];
}

-(void)showGuideVC
{
    UIViewController *guideVC = [self.delegate guideViewController];
    
    if (guideVC == nil)
    {
        self.window.rootViewController = [self.delegate mainViewController];
    }
}

-(void)setWindow:(UIWindow *)window
{
    _window = window;
    self.window.backgroundColor = [UIColor whiteColor];
}

#pragma mark - KKViewControllerChangeDelegate
- (void)pushViewController:(id)aPreController
              toController:(NSString *)aDesControllerName
                     paras:(NSDictionary *)aParas
{
    
    if (aPreController==nil||aDesControllerName==nil) {
//        DDLogError(@"跳转页面不能为空");
    }
    
    
    Class controllerClass = KKClassFromName(aDesControllerName);

    BaseViewController *viewController = [((BaseViewController *)[controllerClass alloc]) initWithDelegate:self paras:aParas];

    if ([aPreController isKindOfClass:[BaseViewController class]])
    {
        BaseViewController *VC = aPreController;
        if (nil != VC.navigationController)
        {
            [VC.navigationController pushViewController:viewController animated:YES];
        }
        else
        {
          //  DDLogError(@"当前页面没有导航条，不可以进行push操作");
        }
    }
    else if ([aPreController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navVC = aPreController;
        [navVC pushViewController:viewController animated:YES];
    }
}

- (void)presentModalViewController:(id)aPreController
                      toController:(NSString *)aDesControllerName
                           withNav:(BOOL)aWrapNav
                             paras:(NSDictionary *)aParas
{
    if (aPreController==nil||aDesControllerName==nil)
    {
//        DDLogError(@"跳转页面不能为空");
    }
    
    Class controllerClass = KKClassFromName(aDesControllerName);
    
    BaseViewController *viewController = [((BaseViewController *)[controllerClass alloc]) initWithDelegate:self paras:nil];

    BaseViewController *VC = aPreController;
    
    if (aWrapNav)
    {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        
        [VC presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [VC presentViewController:viewController animated:YES completion:^{
        }];
    }
}

@end

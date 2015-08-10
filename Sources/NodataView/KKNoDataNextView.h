//
//  KKNoDataNextView.h
//  KaKa
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//  需要跳转到某一页面

#import "KKNoDataBaseView.h"

@interface KKNoDataNextView : KKNoDataBaseView

//下一步按钮
@property (nonatomic, strong) UIButton *goNextBtn;

///  @brief  <#Description#>
///
///  @param aBGName <#aBGName description#>
///
///  @return <#return value description#>
- (id)initWithBgName:(NSString *)aBGName;

/**
 *  <#Description#>
 *
 *  @param aTarget <#aTarget description#>
 *  @param aAction <#aAction description#>
 */
- (void) addTouch:(id)aTarget action:(SEL)aAction;

@end

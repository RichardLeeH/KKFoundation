//
//  UIView+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/1/22.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KaKa)

@property (nonatomic, assign) CGSize kkSize;

@property (nonatomic, assign) CGFloat kkLeft;
@property (nonatomic, assign) CGFloat kkRight;
@property (nonatomic, assign) CGFloat kkTop;
@property (nonatomic, assign) CGFloat kkBottom;

@property (nonatomic, assign) CGFloat kkCenterX;
@property (nonatomic, assign) CGFloat kkCenterY;

@property (nonatomic, assign) CGFloat kkWidth;
@property (nonatomic, assign) CGFloat kkHeight;

-(void)removeAllSubviews;


-(id)userObject;
-(void)setUserObject:(NSObject*)userObject;
-(UIImage *)screenShots;
-(void)makeRoundCorner:(float)radius withClip:(BOOL)clip;
-(void)makeBorder:(UIColor*)color withWidth:(float)width;
-(void)makeShadow:(CGSize)offset withColor:(UIColor*)color withRadius:(float)radius;

/**
 *  获取当前UIVIEW 所在的UIViewController
 *
 *  @return <#return value description#>
 */
- (UIViewController *)viewController;

@end

//
//  UIView+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/1/22.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UIView+KaKa.h"
#import "objc/runtime.h"

@implementation UIView (KaKa)
- (void)setKkSize:(CGSize)size
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)kkSize;
{
    return [self frame].size;
}

- (CGFloat)kkLeft;
{
    return CGRectGetMinX([self frame]);
}

- (void)setKkLeft:(CGFloat)left
{
    CGRect frame = [self frame];
    frame.origin.x = left;
    [self setFrame:frame];
}

- (CGFloat)kkTop;
{
    return CGRectGetMinY([self frame]);
}

- (void)setKkTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)kkRight;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setKkRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)kkBottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setKkBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)kkCenterX;
{
    return [self center].x;
}

- (void)setKkCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)kkCenterY;
{
    return [self center].y;
}

- (void)setKkCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)kkWidth;
{
    return CGRectGetWidth([self frame]);
}

- (void)setKkWidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)kkHeight;
{
    return CGRectGetHeight([self frame]);
}

- (void)setKkHeight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}

-(void)removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(id)userObject
{
    return objc_getAssociatedObject(self, @selector(userObject));
}

-(void)setUserObject:(NSObject*)userObject
{
    objc_setAssociatedObject(self, @selector(userObject), userObject, OBJC_ASSOCIATION_RETAIN);
}

-(UIImage *)screenShots
{
    UIGraphicsBeginImageContextWithOptions(self.kkSize, YES, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}

-(void)makeBorder:(UIColor *)color withWidth:(float)width
{
    CALayer *layer = self.layer;
    [layer setBorderColor:[color CGColor]];
    [layer setBorderWidth:width];
}

-(void)makeRoundCorner:(float)radius withClip:(BOOL)clip
{
    CALayer *layer = self.layer;
    [layer setCornerRadius:radius];
    [layer setMasksToBounds:clip];
    
    for (CALayer *tmpLayer in layer.sublayers)
    {
        if (CGRectEqualToRect(tmpLayer.bounds, layer.bounds))
        {
            [tmpLayer setCornerRadius:radius];
            [tmpLayer setMasksToBounds:clip];
        }
    }
}

-(void)makeShadow:(CGSize)offset withColor:(UIColor *)color withRadius:(float)radius
{
    CALayer *layer = self.layer;
    [layer setShadowOffset:offset];
    [layer setShadowRadius:radius];
    [layer setShadowOpacity:0.5];
    [layer setShadowColor:color.CGColor];
}

/**
 *  获取当前UIVIEW 所在的UIViewController
 *
 *  @return <#return value description#>
 */
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

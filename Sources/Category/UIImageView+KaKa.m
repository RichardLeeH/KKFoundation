//
//  UIImageView+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/2/4.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UIView+KaKa.h"
#import "UIImage+KaKa.h"
#import "UIImageView+KaKa.h"
#import "Utils.h"

@implementation UIImageView(KaKa)

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage = nil;
    if (nil == image && self.image != nil) {
        newimage = self.image;
    }
    //    else{
    CGRect  newrect;
    float newX;
    float newY;
    float newW;
    float newH;
    
    
    
    CGSize  imagesize = image.size;
    if (imagesize.width > imagesize.height) {
        newH = imagesize.height;
        newW = newH;
        newY = 0;
        newX = imagesize.width/2-newW/2;
        newrect = CGRectMake(newX, newY, newW, newH);
    }else if (imagesize.width < imagesize.height){
        newW = imagesize.width;
        newH = newW;
        newX = 0;
        newY = imagesize.height/2 - newH/2;
        newrect = CGRectMake(newX, newY, newW, newH);
    }else
    {
        newrect = CGRectMake(0, 0, imagesize.width, imagesize.height);
    }
    
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, newrect);
    UIGraphicsBeginImageContext(newrect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, newrect, subImageRef);
    newimage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return newimage;
}

+(void)startImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;
{
    //围绕Z轴旋转，垂直与屏幕
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    animation.fromValue = @(0.0);  // 设定动画起始帧和结束帧
    animation.toValue = @(M_PI);
    animation.duration = 0.5;  //动画持续时间
    animation.cumulative = YES;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.repeatCount = 1e100;  //重复次数
    [currentImg.layer addAnimation:animation forKey:key];
}

+(void)stopImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;
{
    [currentImg.layer removeAnimationForKey:key];
}

-(id)initWithImageName:(NSString *)name
{
    self = [super init];
    
    UIImage *img = kkImageNamed(name);
    if (img) {
        self.kkSize = img.kkSize;
        self.image = img;
    }
    
    return self;
}
@end

//
//  UIImageView+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/2/4.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView(KaKa)
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
+(void)startImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;
+(void)stopImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;

-(id)initWithImageName:(NSString*)name;
@end

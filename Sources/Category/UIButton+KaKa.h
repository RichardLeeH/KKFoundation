//
//  UIButton+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/1/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KaKa)

-(id)initWithTitle:(NSString*)title withFont:(UIFont*)font withColor:(UIColor*)color;
-(id)initWithBgImageName:(NSString*)name;
-(id)initWithBgImageName:(NSString*)name withSize:(CGSize)size;
-(void)setImageWithName:(NSString*)name;
@end

//
//  KKControlBuildFactory.m
//  KaKa
//
//  Created by 宋迪 on 15/6/1.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "KKControlBuildFactory.h"

@implementation KKControlBuildFactory

+(UILabel*)createLabelWithFont:(UIFont*)font text:(NSString*)text textColor:(UIColor*)textColor{
    UILabel *label = [UILabel new];
    if (font) {
        label.font = font;
    }
    if (textColor) {
        label.textColor  = textColor;
    }
    if (text) {
        label.text = text;
    }
    return label;
}

@end

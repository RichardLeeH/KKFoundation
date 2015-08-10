//
//  KKControlBuildFactory.h
//  KaKa
//
//  Created by 宋迪 on 15/6/1.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KKControlBuildFactory : NSObject

+(UILabel*)createLabelWithFont:(UIFont*)font text:(NSString*)text textColor:(UIColor*)textColor;

@end

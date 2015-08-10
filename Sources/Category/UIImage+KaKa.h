//
//  UIImage+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/1/21.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface UIImage (KaKa)

/**
 *  根据名称获取图片，无缓存
 *
 *  @param aFileName
 *
 *  @return instancetype
 */
+ (instancetype)createImage:(NSString *)aFileName;

+(instancetype)imageFromBundle:(NSString*)name;
+(instancetype)imageFromDocuments:(NSString*)name;

+(instancetype)imageNamedFor2X:(NSString*)name;
+(instancetype)imageNamedFor3X:(NSString*)name;
+(instancetype)imageNamedFor6:(NSString*)name;
+(instancetype)imageNamedFor6Plus:(NSString*)name;
+(instancetype)imageWithColor:(UIColor*)color withSize:(CGSize)size;

-(instancetype)imageScaleToSize:(CGSize)size;
-(instancetype)imageRotate:(ALAssetOrientation)orientation;

-(CGSize)kkSize;

@end

@interface UIImage (compress)

/**
 *  压缩为PNG格式
 *
 *  @return UIImage
 */
- (NSData *)pngCompress;

/**
 *  压缩为JPEG
 *
 *  @param aCompressionQuality 压缩质量
 *
 *  @return UIImage
 */
- (NSData *)jpegCompress:(CGFloat)aCompressionQuality;

@end


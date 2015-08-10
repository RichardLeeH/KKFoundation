//
//  UIImage+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/1/21.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UIImage+KaKa.h"
#import "Utils.h"

@implementation UIImage (KaKa)

/**
 *  根据名称获取图片，无缓存
 *
 *  @param aFileName
 *
 *  @return instancetype
 */
+ (instancetype)createImage:(NSString *)aFileName;
{
    NSString *path = [[NSBundle mainBundle] pathForResource:aFileName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

+(UIImage *)imageFromBundle:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
}

+(UIImage *)imageFromDocuments:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *file = [docDir stringByAppendingPathComponent:name];
    
    return [UIImage imageWithContentsOfFile:file];
}

+(instancetype)imageNamedFor2X:(NSString*)name
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png", name]];
}

+(instancetype)imageNamedFor3X:(NSString*)name
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@@3x.png", name]];
}

+(instancetype)imageNamedFor6:(NSString*)name
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@@6.png", name]];
}

+(instancetype)imageNamedFor6Plus:(NSString*)name
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@@6+.png", name]];
}

+(instancetype)imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(instancetype)imageScaleToSize:(CGSize)size
{
    NSLog(@"%@", NSStringFromCGSize(self.size));
    float delta = sqrt(size.width * size.height) / sqrt(self.size.width * self.size.height);

    if (delta > 1) {
        return self;
    }
    
    size = CGSizeMake(self.size.width*delta, self.size.height*delta);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(instancetype)imageRotate:(ALAssetOrientation)orientation
{
    if (orientation == ALAssetOrientationRight)
    {
        return [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
    }
    else if (orientation == ALAssetOrientationLeft)
    {
        return [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
    }
    
    return self;
}

-(CGSize)kkSize
{
    if (iPhone6)
    {
        float delta = 375.0f/320.0f;
        return CGSizeMake(self.size.width * delta, self.size.height * delta);
    }
    
    return self.size;
}

@end

@implementation UIImage (compress)

/**
 *  压缩为PNG格式
 *
 *  @return UIImage
 */
- (NSData *)pngCompress
{
    return UIImagePNGRepresentation(self);
}

/**
 *  压缩为JPEG
 *
 *  @param aCompressionQuality 压缩质量
 *
 *  @return UIImage
 */
- (NSData *)jpegCompress:(CGFloat)aCompressionQuality
{
    return UIImageJPEGRepresentation(self, aCompressionQuality);
}

@end

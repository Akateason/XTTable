//
//  UIImage+AddFunction.h
//  ParkingSys
//
//  Created by mini1 on 14-6-13.
//  Copyright (c) 2014年 mini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

__attribute__((deprecated("Class UIImage (AddFunction) is deprecated , use UIImage (XT) instead!!!")))

@interface UIImage (AddFunction)

#pragma mark--
#pragma mark - style
//1.裁剪圆形 + 边框
- (UIImage *)cutImageWithCircleWithBorderWidth:(CGFloat)margin
                            AndWithBorderColor:(UIColor *)borderColor;

+ (UIImage *)image:(UIImage *)image
          rotation:(UIImageOrientation)orientation;

//2.裁剪正方
+ (UIImage *)squareImageFromImage:(UIImage *)image
                     scaledToSize:(CGFloat)newSize;

//3.添加水印
- (UIImage *)imageWithWaterMask:(UIImage *)mask
                         inRect:(CGRect)rect;

//4.缩略图thumbnail
+ (UIImage *)thumbnailWithImage:(UIImage *)image
                           size:(CGSize)asize;
// 等比缩放
- (UIImage *)imageCompressWithTargetSize:(CGSize)size;
- (UIImage *)imageCompressWithTargetWidth:(CGFloat)defineWidth;

// 压缩图片质量
+ (UIImage *)compressQualityWithOriginImage:(UIImage *)sourceImage;

// 相册获取
+ (UIImage *)fetchFromLibrary:(ALAsset *)asset;

//5.拍完照片的自适应旋转(和相机一起用)
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//6.颜色变图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

//7.将UIView转成UIImage
+ (UIImage *)getImageFromView:(UIView *)theView;

//8.模糊
- (UIImage *)blur;

- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

#pragma mark--
#pragma mark - convert
//1.UIimage转换NSdata
- (NSData *)imageToData;
//2.NSdata转换UIimage
- (UIImage *)dataToImage:(NSData *)_data;

@end

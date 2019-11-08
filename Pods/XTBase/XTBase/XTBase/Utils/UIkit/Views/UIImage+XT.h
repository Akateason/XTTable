//
//  UIImage+XT.h
//  XTBase
//
//  Created by teason23 on 2019/10/17.
//  Copyright © 2019 teason23. All rights reserved.
//


#import <UIKit/UIKit.h>



@interface UIImage (XT)

/// CG - 切圆角 (若遇到不规则的图片, 需要先调用"裁剪正方形", 再切圆角.)
- (UIImage *)xt_cutImageWithCircleWithBorderWidth:(CGFloat)margin
                                      borderColor:(UIColor *)borderColor ;

/// 改变朝向
- (UIImage *)xt_changeImageRotation:(UIImageOrientation)orientation ;

/// 裁剪正方形
- (UIImage *)xt_makeSquareImageScaledToSize:(CGFloat)newSize ;

/// 加入水印
- (UIImage *)xt_imageWithWaterMask:(UIImage *)mask
                            inRect:(CGRect)rect ;

/// 缩略图
- (UIImage *)xt_thumbnailWithSize:(CGSize)aSize ;
/// 按指定 size 等比缩放
- (UIImage *)xt_imageCompressWithTargetSize:(CGSize)size ;
/// 按指定 宽度 等比缩放
- (UIImage *)xt_imageCompressWithTargetWidth:(CGFloat)defineWidth ;

/// 拍完照片的自适应旋转(和相机一起用)
+ (UIImage *)xt_fixOrientation:(UIImage *)aImage ;


/// 把颜色变成一张图片
+ (UIImage *)xt_getImageWithColor:(UIColor *)color
                             size:(CGSize)size ;
/// 图片染色
- (UIImage *)xt_imageWithTintColor:(UIColor *)tintColor ;

- (UIImage *)xt_imageWithGradientTintColor:(UIColor *)tintColor ;

- (UIImage *)xt_imageWithTintColor:(UIColor *)tintColor
                         blendMode:(CGBlendMode)blendMode ;

/// view转image
+ (UIImage *)xt_getImageFromView:(UIView *)theView ;

/// blur
- (UIImage *)xt_blur ;
- (UIImage *)xt_boxblurImageWithBlur:(CGFloat)blur ;

/// image to data
- (NSData *)xt_imageToData ;
// data to image
- (UIImage *)xt_dataToImage:(NSData *)data ;


@end



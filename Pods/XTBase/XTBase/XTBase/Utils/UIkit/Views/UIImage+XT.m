//
//  UIImage+XT.m
//  XTBase
//
//  Created by teason23 on 2019/10/17.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "UIImage+XT.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>



@implementation UIImage (XT)




- (UIImage *)xt_cutImageWithCircleWithBorderWidth:(CGFloat)margin
                                      borderColor:(UIColor *)borderColor {
    //1.创建图层,此图大一些作为外框
    //CGFloat margin = 5;
    CGFloat imageNewWidth  = self.size.width + margin;
    CGFloat imageNewHeight = self.size.width + margin;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageNewWidth, imageNewHeight), NO, 0.0);

    //2.创建设备上下文，此时得到的上下文是图层的上下文。原因是上面创建了图层
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    //3.在图层中绘制一个大圆，作为外框
    CGContextAddEllipseInRect(ctr, CGRectMake(0, 0, imageNewWidth, imageNewHeight));
    [borderColor set];
    CGContextFillPath(ctr);

    //3.绘制小圆作为剪切图片的用
    [[UIColor blueColor] set];
    CGContextAddEllipseInRect(ctr, CGRectMake(margin, margin, imageNewWidth - 2 * margin, imageNewHeight - 2 * margin));
    //4.按照当前的模式裁剪，裁剪只对后面绘制的图层有效 对已经绘制的图层无效
    CGContextClip(ctr);
    CGContextStrokePath(ctr);

    //5.绘制图片
    [self drawAtPoint:CGPointMake(0, 0)];
    //6.从当前图层中获得Image
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    //7.结束图层
    UIGraphicsEndImageContext();

    //8.绘制上文得到的Image到View中
    [imageNew drawAtPoint:CGPointMake(0, 0)];
    return imageNew;
}

- (UIImage *)xt_changeImageRotation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX     = 1.0;
    float scaleY     = 1.0;

    switch (orientation) {
        case UIImageOrientationLeft:
            rotate     = M_PI_2;
            rect       = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY     = rect.size.width / rect.size.height;
            scaleX     = rect.size.height / rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate     = 3 * M_PI_2;
            rect       = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY     = rect.size.width / rect.size.height;
            scaleX     = rect.size.height / rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate     = M_PI;
            rect       = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate     = 0.0;
            rect       = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);

    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);

    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}


- (UIImage *)xt_makeSquareImageScaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;

    if (self.size.width > self.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / self.size.height;
        scaleTransform     = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(self.size.width - self.size.height) / 2.0f, 0);
    }
    else {
        CGFloat scaleRatio = newSize / self.size.width;
        scaleTransform     = CGAffineTransformMakeScale(scaleRatio, scaleRatio);

        origin = CGPointMake(0, -(self.size.height - self.size.width) / 2.0f);
    }

    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    }
    else {
        UIGraphicsBeginImageContext(size);
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [self drawAtPoint:origin];
        
    //获取缩放后剪切的image图片
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}



- (UIImage *)xt_imageWithWaterMask:(UIImage *)mask
                            inRect:(CGRect)rect {
    
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //水印图
    [mask drawInRect:rect] ;
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}



- (UIImage *)xt_thumbnailWithSize:(CGSize)aSize {
    UIImage *newimage ;
    CGSize oldsize = self.size;
    CGRect rect;
    double d = oldsize.width / oldsize.height ;
    if (d > 1) aSize.width = aSize.height * d ;
    else aSize.height = aSize.width / d ;
    
    rect.size.width  = aSize.width;
    rect.size.height = aSize.height;
    rect.origin.x    = 0;
    rect.origin.y    = 0;

    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}


- (UIImage *)xt_imageCompressWithTargetSize:(CGSize)size {
    UIImage *newImage      = nil;
    CGSize imageSize       = self.size;
    CGFloat width          = imageSize.width;
    CGFloat height         = imageSize.height;
    CGFloat targetWidth    = size.width;
    CGFloat targetHeight   = size.height;
    CGFloat scaleFactor    = 0.0;
    CGFloat scaledWidth    = targetWidth;
    CGFloat scaledHeight   = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor  = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        }
        else {
            scaleFactor = heightFactor;
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    UIGraphicsBeginImageContext(size);

    CGRect thumbnailRect      = CGRectZero;
    thumbnailRect.origin      = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if (newImage == nil) {
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)xt_imageCompressWithTargetWidth:(CGFloat)defineWidth {
    UIImage *newImage      = nil;
    CGSize imageSize       = self.size;
    CGFloat width          = imageSize.width;
    CGFloat height         = imageSize.height;
    CGFloat targetWidth    = defineWidth;
    CGFloat targetHeight   = height / (width / targetWidth);
    CGSize size            = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor    = 0.0;
    CGFloat scaledWidth    = targetWidth;
    CGFloat scaledHeight   = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor  = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        }
        else {
            scaleFactor = heightFactor;
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect      = CGRectZero;
    thumbnailRect.origin      = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [self drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();
    return newImage;
}



+ (UIImage *)xt_fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img     = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



+ (UIImage *)xt_getImageWithColor:(UIColor *)color
                             size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)xt_imageWithTintColor:(UIColor *)tintColor {
    return [self xt_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)xt_imageWithGradientTintColor:(UIColor *)tintColor {
    return [self xt_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)xt_imageWithTintColor:(UIColor *)tintColor
                         blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);

    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];

    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }

    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}



+ (UIImage *)xt_getImageFromView:(UIView *)theView {
    CGSize orgSize = theView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(orgSize, YES, theView.layer.contentsScale * 2);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (UIImage *)xt_blur {
    // create our blurred image
    CIContext *context  = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];

    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform     = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];

    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];

    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];

    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];

    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage); //release CGImageRef because ARC doesn't manage this on its own.

    return returnImage;
}


- (UIImage *)xt_boxblurImageWithBlur:(CGFloat)blur {
    NSData *imageData  = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage *destImage = [UIImage imageWithData:imageData];
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize     = boxSize - (boxSize % 2) + 1;

    CGImageRef img = destImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;


    //create vImage_Buffer with data from CGImageRef

    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);

    inBuffer.width    = CGImageGetWidth(img);
    inBuffer.height   = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    if (pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");

    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height   = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data     = pixelBuffer2;
    outBuffer2.width    = CGImageGetWidth(img);
    outBuffer2.height   = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);

    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx           = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef  = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);

    CGImageRelease(imageRef);

    return returnImage;
}




- (NSData *)xt_imageToData {
    NSData *dataVphoto = nil;
    if (UIImagePNGRepresentation(self) == nil) {
        dataVphoto = UIImageJPEGRepresentation(self, 1);
    }
    else {
        dataVphoto = UIImagePNGRepresentation(self);
    }
    return dataVphoto;
}

- (UIImage *)xt_dataToImage:(NSData *)data {
    return [UIImage imageWithData:data] ;
}



@end

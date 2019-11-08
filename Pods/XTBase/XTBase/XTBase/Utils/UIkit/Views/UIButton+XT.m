//
//  UIButton+XT.m
//  XTlib
//
//  Created by teason23 on 2018/11/1.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UIButton+XT.h"
#import <objc/runtime.h>


@implementation UIButton (XT)

@end


@implementation UIButton (ExtendTouchRect)
void Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod  = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

+ (void)load {
    Swizzle(self, @selector(pointInside:withEvent:), @selector(myPointInside:withEvent:));
}

- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self myPointInside:point withEvent:event]; // original implementation
    }

    CGRect hitFrame      = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width  = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char touchExtendInsetKey;
- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset {
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:touchExtendInset], OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)touchExtendInset {
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue];
}


// enlarge e.g. UIEdgeInsetsMake(-15, -15, -15, -15) ;
- (void)xt_enlargeButtonsTouchArea {
    self.touchExtendInset = UIEdgeInsetsMake(-kDefaultEnlargeFlex, -kDefaultEnlargeFlex, -kDefaultEnlargeFlex, -kDefaultEnlargeFlex);
}
@end


@implementation UIButton (Countdown)
- (void)xt_startWithTime:(NSInteger)timeLine
                   title:(NSString *)title
          countDownTitle:(NSString *)subTitle
               mainColor:(UIColor *)mColor
              countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{

        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title
                      forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }
        else {
            int seconds       = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, subTitle]
                      forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
@end


@interface XTButtonPositionCacheManager : NSObject
@property (nonatomic, strong) NSCache *cache;
@end


@implementation XTButtonPositionCacheManager
+ (instancetype)sharedInstance {
    static XTButtonPositionCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    return self;
}
@end


/**
 缓存用数据结构
 */
@interface XTButtonPositionCacheModel : NSObject
@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@end


@implementation XTButtonPositionCacheModel
@end


@implementation UIButton (LXMImagePosition)
- (void)xt_setImagePosition:(XTBtImagePosition)postion
                    spacing:(CGFloat)spacing {
    NSCache *cache                         = [XTButtonPositionCacheManager sharedInstance].cache;
    NSString *cacheKey                     = [NSString stringWithFormat:@"%@_%@_%@", self.currentTitle, @(self.titleLabel.font.hash), @(postion)];
    XTButtonPositionCacheModel *savedModel = [cache objectForKey:cacheKey];
    if (savedModel != nil) {
        self.imageEdgeInsets   = savedModel.imageEdgeInsets;
        self.titleEdgeInsets   = savedModel.titleEdgeInsets;
        self.contentEdgeInsets = savedModel.contentEdgeInsets;
        return;
    }

    CGFloat imageWidth  = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    // Single line, no wrapping. Truncation based on the NSLineBreakMode.
    CGSize size         = [self.currentTitle sizeWithFont:self.titleLabel.font];
    CGFloat labelWidth  = size.width;
    CGFloat labelHeight = size.height;
#pragma clang diagnostic pop

    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;                //image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;                                 //image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2; //label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;                                 //label中心移动的y距离

    CGFloat tempWidth     = MAX(labelWidth, imageWidth);
    CGFloat changedWidth  = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight    = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;

    UIEdgeInsets imageEdgeInsets   = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets   = UIEdgeInsetsZero;
    UIEdgeInsets contentEdgeInsets = UIEdgeInsetsZero;

    switch (postion) {
        case XTBtImagePositionLeft:
            imageEdgeInsets   = UIEdgeInsetsMake(0, -spacing / 2, 0, spacing / 2);
            titleEdgeInsets   = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
            contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;

        case XTBtImagePositionRight:
            imageEdgeInsets   = UIEdgeInsetsMake(0, labelWidth + spacing / 2, 0, -(labelWidth + spacing / 2));
            titleEdgeInsets   = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2), 0, imageWidth + spacing / 2);
            contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;

        case XTBtImagePositionTop:
            imageEdgeInsets   = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            titleEdgeInsets   = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth / 2, changedHeight - imageOffsetY, -changedWidth / 2);
            break;

        case XTBtImagePositionBottom:
            imageEdgeInsets   = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            titleEdgeInsets   = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY, -changedWidth / 2, imageOffsetY, -changedWidth / 2);
            break;
        default:
            break;
    }

    XTButtonPositionCacheModel *model = [[XTButtonPositionCacheModel alloc] init];
    model.imageEdgeInsets             = imageEdgeInsets;
    model.titleEdgeInsets             = titleEdgeInsets;
    model.contentEdgeInsets           = contentEdgeInsets;
    [cache setObject:model forKey:cacheKey];

    self.imageEdgeInsets   = imageEdgeInsets;
    self.titleEdgeInsets   = titleEdgeInsets;
    self.contentEdgeInsets = contentEdgeInsets;
}


@end

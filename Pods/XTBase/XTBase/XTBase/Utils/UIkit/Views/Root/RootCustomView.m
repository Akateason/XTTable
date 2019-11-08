//
//  RootCustomView.m
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "RootCustomView.h"
#import "NSObject+XTRuntime.h"
#import "FastCodeHeader.h"


@interface UIView ()
@property (nonatomic) CGRect xt_previousRect;
@property (weak, nonatomic) CALayer *xt_gradientLayer;
@end


@implementation UIView (XTRootCustom)

// public
- (void)setXt_completeRound:(BOOL)xt_completeRound {
    self.layer.cornerRadius  = xt_completeRound ? CGRectGetHeight(self.bounds) / 2.f : 0;
    self.layer.masksToBounds = xt_completeRound;
}
- (BOOL)xt_completeRound {
    return CGRectGetHeight(self.bounds) / 2.f == self.layer.cornerRadius ;
}

- (void)setXt_cornerRadius:(float)xt_cornerRadius {
    self.layer.cornerRadius = xt_cornerRadius;
}
- (float)xt_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setXt_borderWidth:(float)xt_borderWidth {
    self.layer.borderWidth = xt_borderWidth;
}
- (float)xt_borderWidth {
    return self.layer.borderWidth;
}

- (void)setXt_borderColor:(UIColor *)xt_borderColor {
    self.layer.borderColor = xt_borderColor.CGColor;
}
- (UIColor *)xt_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setXt_maskToBounds:(BOOL)xt_maskToBounds {
    self.layer.masksToBounds = xt_maskToBounds;
}
- (BOOL)xt_maskToBounds {
    return self.layer.masksToBounds;
}

ASSOCIATED_CGPOINT(xt_gradientPt0, setXt_gradientPt0);
ASSOCIATED_CGPOINT(xt_gradientPt1, setXt_gradientPt1);
ASSOCIATED(xt_gradientColor0, setXt_gradientColor0, UIColor *, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
ASSOCIATED(xt_gradientColor1, setXt_gradientColor1, UIColor *, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

// private
ASSOCIATED(xt_gradientLayer, setXt_gradientLayer, CALayer *, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
ASSOCIATED_CGRECT(xt_previousRect, setXt_previousRect);


#pragma mark -

- (void)layoutSubviews {
    if (!self.xt_gradientColor0 || !self.xt_gradientColor1) return;

    if (!CGRectEqualToRect(self.bounds, self.xt_previousRect)) {
        self.xt_previousRect = self.bounds;
        if (!self.xt_gradientLayer) {
            CAGradientLayer *layer = [CAGradientLayer new];
            layer.colors           = @[ (__bridge id)self.xt_gradientColor0.CGColor, (__bridge id)self.xt_gradientColor1.CGColor ];
            layer.startPoint       = self.xt_gradientPt0;
            layer.endPoint         = self.xt_gradientPt1;
            layer.frame            = self.xt_previousRect;

            self.xt_gradientLayer = layer;
            [self.layer insertSublayer:self.xt_gradientLayer atIndex:0];
        }
        self.xt_gradientLayer.frame = self.xt_previousRect;
    }
}

@end


@implementation RootCustomView
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end


@implementation RootCustomImageView
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end


@implementation RootCustomButton
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end


@implementation RootCustomLabel
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end


@implementation RootCustomTextField
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end


@implementation RootCustomTextView
- (instancetype)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end

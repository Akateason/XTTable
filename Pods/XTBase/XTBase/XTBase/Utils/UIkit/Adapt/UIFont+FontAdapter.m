//
//  UIFont+FontAdapter.h
//  XTkit
//
//  Created by teason23 on 2017/8/23.
//  Copyright © 2017年 teason. All rights reserved.

#import "UIFont+FontAdapter.h"
#import <objc/runtime.h>
#import "ScreenHeader.h"

// 这里设置iPhone6Plus放大的字号数（现在是放大3号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为18）
#define IPHONE6PLUS_INCREMENT 0
#define IPHONE6BLOW_REDUCE 2


@implementation UIFont (FontAdapter)

- (void)adjustFont:(CGFloat)fontSize {
    float tmpSize = 0.;
    if (XT_IS_IPHONE_6) {
        tmpSize = fontSize;
    }
    else if (XT_GREATER_THAN_IPHONE_6) {
        tmpSize = fontSize + IPHONE6PLUS_INCREMENT;
    }
    else {
        if (fontSize <= 12) {
            tmpSize = fontSize;
        }
        else {
            tmpSize = fontSize - IPHONE6BLOW_REDUCE;
        }
    }
    [self fontWithSize:tmpSize];
}

@end


static void ExchangedMethod(SEL originalSelector, SEL swizzledSelector, Class class) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation UILabel (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class);
    });
}

- (id)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        // 部分不像改变字体的 把tag值设置成333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.font.pointSize;
            [self.font adjustFont:fontSize];
        }
    }
    return self;
}

@end


@implementation UIButton (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class);
    });
}

- (id)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不想改变字体的 把tag值设置成333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.titleLabel.font.pointSize;
            [self.titleLabel.font adjustFont:fontSize];
        }
    }
    return self;
}

@end


@implementation UITextField (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class);
    });
}

- (id)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不想改变字体的 把tag值设置成333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.font.pointSize;
            [self.font adjustFont:fontSize];
        }
    }
    return self;
}

@end

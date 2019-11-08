//
//  UIView+XTAddition.m
//  XTkit
//
//  Created by xtc on 2018/2/5.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "UIView+XTAddition.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "ScreenHeader.h"
#import <objc/runtime.h>


@implementation UIView (XTAddition)

/**
 清楚所有键盘等
 */
- (void)xt_resignAllResponderWhenTapThis {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }];
    [self addGestureRecognizer:tap];
}

/**
 *  获取最顶层window
 */
+ (UIWindow *)xt_topWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)) {
            return window;
        }
    }
    return nil;
}


+ (CGRect)currentScreenBoundsDependOnOrientation {
    CGRect screenBounds                         = [UIScreen mainScreen].bounds;
    CGFloat width                               = CGRectGetWidth(screenBounds);
    CGFloat height                              = CGRectGetHeight(screenBounds);
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        screenBounds.size = CGSizeMake(width, height);
    }
    else if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        screenBounds.size = CGSizeMake(height, width);
    }
    
    return screenBounds;
}

@end


@interface UIView ()
@property (strong, nonatomic, readwrite) UIViewController *xt_viewController;
@property (strong, nonatomic, readwrite) UINavigationController *xt_navigationController;
@end


@implementation UIView (CurrentController)
@dynamic xt_navigationController, xt_viewController;

- (UIViewController *)xt_viewController {
    UIViewController *resultVC = nil;
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            resultVC = (UIViewController *)nextResponder;
            break;
        }
    }

    return resultVC;
}

- (UINavigationController *)xt_navigationController {
    return self.xt_viewController.navigationController;
}

static NSString *const kSeperateLine = @"/";
/**
 view chainInfo
 @return string  @"subview/superview/currentController"
 */
- (NSString *)xt_chainInfo {
    NSMutableString *tmpString = [@"" mutableCopy];
    for (UIView *next = self; next; next = next.superview) {
        [tmpString appendFormat:@"%@%@", NSStringFromClass(next.class), kSeperateLine];
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            [tmpString appendFormat:@"%@%@", NSStringFromClass(nextResponder.class), kSeperateLine];
            break;
        }
    }
    return tmpString;
}

@end


@implementation UIView (MakeScollView)

- (UIScrollView *)xt_wrapperWithScrollView {
    UIScrollView *scroll                  = [[UIScrollView alloc] init];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator   = NO;
    scroll.bounces                        = YES;

    [scroll addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.bottom.equalTo(scroll);
    }];
    return scroll;
}

- (UIScrollView *)xt_wrapperWithHorizontalScrollView {
    UIScrollView *scroll                  = [[UIScrollView alloc] init];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator   = NO;
    scroll.bounces                        = YES;

    [scroll addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.right.equalTo(scroll);
    }];
    return scroll;
}

@end


@implementation UIView (XTNib)

+ (instancetype)xt_newFromNib {
    return [self xt_newFromNibByBundle:[NSBundle mainBundle]];
}

+ (instancetype)xt_newFromNibByBundle:(NSBundle *)bundle {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    return [[nib instantiateWithOwner:nil options:nil] firstObject];
}

@end

//
//  UIViewController+XTAddition.m
//  XTlib
//
//  Created by teason23 on 2018/3/14.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UIViewController+XTAddition.h"
#import <objc/runtime.h>
#import "ScreenHeader.h"
#import <Masonry/Masonry.h>

//////////////////////////////////////////////////////////////////////////////////////////


@implementation UIViewController (XTAddition)

#pragma mark - new from Story or NIB

+ (instancetype)getCtrllerFromStory:(NSString *)storyboard
                             bundle:(NSBundle *)bundle
               controllerIdentifier:(NSString *)identifier {
    UIStoryboard *story       = [UIStoryboard storyboardWithName:storyboard bundle:bundle];
    UIViewController *ctrller = [story instantiateViewControllerWithIdentifier:identifier];
    return ctrller;
}

+ (instancetype)getCtrllerFromStory:(NSString *)storyboard
               controllerIdentifier:(NSString *)identifier {
    return [self getCtrllerFromStory:storyboard bundle:nil controllerIdentifier:identifier];
}

+ (instancetype)getCtrllerFromNIB {
    return [self getCtrllerFromNIBWithBundle:nil];
}

+ (instancetype)getCtrllerFromNIBWithBundle:(NSBundle *)bundle {
    NSString *clsName         = NSStringFromClass(self.class);
    UIViewController *ctrller = [[[self class] alloc] initWithNibName:clsName bundle:bundle];
    return ctrller;
}

#pragma mark - topVC

+ (UIViewController *)xt_topViewController {
    UIViewController *resultVC;
    resultVC = [self findTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self findTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)findTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self findTopViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self findTopViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else {
        return vc;
    }
    return nil;
}

#pragma mark - wrapper in scrollview

- (void)xt_letSelfViewInScrollView {
    UIScrollView *scroll                  = [[UIScrollView alloc] init];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator   = NO;
    scroll.bounces                        = YES;
    [scroll addSubview:self.view];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.bottom.equalTo(scroll);
    }];
    self.view = scroll;
}

@end

//////////////////////////////////////////////////////////////////////////////////////////


@implementation UIViewController (Navigation)

+ (void)load {
    [super load];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector  = @selector(viewWillDisappear:);
        SEL swizzledSelector  = @selector(xt_viewWillDisappear:);
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        BOOL didAddMethod     = class_addMethod(self.class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(self.class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xt_viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if (self.navigationDidClickBackButton) {
            self.navigationDidClickBackButton();
        }
    }

    [self xt_viewWillDisappear:animated];
}

#pragma mark - prop

static const void *kNavigationDidClickBackButton;
- (void)setNavigationDidClickBackButton:(NavigationBackButtonOnClick)navigationDidClickBackButton {
    objc_setAssociatedObject(self,
                             &kNavigationDidClickBackButton,
                             navigationDidClickBackButton,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NavigationBackButtonOnClick)navigationDidClickBackButton {
    return objc_getAssociatedObject(self,
                                    &kNavigationDidClickBackButton);
}

@end

//////////////////////////////////////////////////////////////////////////////////////////


@implementation UIViewController (TabbarHidden)

- (void)makeTabBarHidden:(BOOL)hide {
    [self makeTabBarHidden:hide animated:NO];
}

- (void)makeTabBarHidden:(BOOL)hide animated:(BOOL)animated {
    if ([self.tabBarController.view.subviews count] < 2) return;
    self.tabBarController.tabBar.hidden = hide;
    UIView *contentView;
    if ([[self.tabBarController.view.subviews firstObject] isKindOfClass:[UITabBar class]]) {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else {
        contentView = [self.tabBarController.view.subviews firstObject];
    }
    CGRect newFrame;
    if (hide) {
        newFrame = APPFRAME;
    }
    else {
        newFrame = CGRectMake(APPFRAME.origin.x,
                              APPFRAME.origin.y,
                              APP_WIDTH,
                              APP_HEIGHT - APP_TABBAR_HEIGHT);
    }
    if (animated) {
        [UIView animateWithDuration:0.35f animations:^{
            contentView.frame = newFrame;
        }];
    }
    else {
        contentView.frame = newFrame;
    }
}
@end

//////////////////////////////////////////////////////////////////////////////////////////

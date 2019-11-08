//
//  UIViewController+XTAddition.h
//  XTlib
//
//  Created by teason23 on 2018/3/14.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

//////////////////////////////////////////////////////////////////////////////////////////


@interface UIViewController (XTAddition)

+ (instancetype)getCtrllerFromStory:(NSString *)storyboard
                             bundle:(NSBundle *)bundle
               controllerIdentifier:(NSString *)identifier;

+ (instancetype)getCtrllerFromStory:(NSString *)storyboard
               controllerIdentifier:(NSString *)identifier;

+ (instancetype)getCtrllerFromNIB;
+ (instancetype)getCtrllerFromNIBWithBundle:(NSBundle *)bundle;

+ (UIViewController *)xt_topViewController;

- (void)xt_letSelfViewInScrollView;

@end

//////////////////////////////////////////////////////////////////////////////////////////

typedef void (^NavigationBackButtonOnClick)(void);


@interface UIViewController (Navigation)
@property (nonatomic, copy) NavigationBackButtonOnClick navigationDidClickBackButton;
@end

//////////////////////////////////////////////////////////////////////////////////////////


@interface UIViewController (TabbarHidden)
- (void)makeTabBarHidden:(BOOL)hide;
- (void)makeTabBarHidden:(BOOL)hide
                animated:(BOOL)animated;
@end

//////////////////////////////////////////////////////////////////////////////////////////

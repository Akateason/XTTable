//
//  UIAlertController+XTAddition.h
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIAlertController (XTAddition)


/**
 normal alert - ipad any
 */
+ (void)xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                                title:(NSString *)title
                                              message:(NSString *)message
                                    cancelButtonTitle:(NSString *)cancelBtnTitle
                               destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                    otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                         fromWithView:(UIView *)fromView
                                        CallBackBlock:(void (^)(NSInteger btnIndex))block ;

/**
 normal alert - ipad from ctrller
 */
+ (void)xt_showAlertCntrollerWithViewController:(UIViewController *)viewController
                           alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                          title:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelBtnTitle
                         destructiveButtonTitle:(NSString *)destructiveBtnTitle
                              otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                   fromWithView:(UIView *)fromView
                                  CallBackBlock:(void (^)(NSInteger btnIndex))block ;


/**
 normal alert - from ctrller
 */
+ (void)xt_showAlertCntrollerWithViewController:(UIViewController *)viewController
                           alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                          title:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelBtnTitle
                         destructiveButtonTitle:(NSString *)destructiveBtnTitle
                              otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                  CallBackBlock:(void (^)(NSInteger btnIndex))block;

/**
 normal alert - any ctrller
 */
+ (void)xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                                title:(NSString *)title
                                              message:(NSString *)message
                                    cancelButtonTitle:(NSString *)cancelBtnTitle
                               destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                    otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                        callBackBlock:(void (^)(NSInteger btnIndex))block;

/**
 textfield alert
 */
+ (void)xt_showTextFieldAlertWithTitle:(NSString *)title
                              subtitle:(NSString *)subTitle
                                cancel:(NSString *)cancelStr
                                commit:(NSString *)commitStr
                           placeHolder:(NSString *)placeHolderStr
                              callback:(void (^)(BOOL isConfirm, NSString *text))textBlock ;

/**
 textfield ipad
 */
+ (void)xt_showTextFieldAlertWithTitle:(NSString *)title
                              subtitle:(NSString *)subTitle
                                cancel:(NSString *)cancelStr
                                commit:(NSString *)commitStr
                           placeHolder:(NSString *)placeHolderStr
                          fromWithView:(UIView *)fromView
                              callback:(void (^)(BOOL isConfirm, NSString *text))textBlock ;

@end

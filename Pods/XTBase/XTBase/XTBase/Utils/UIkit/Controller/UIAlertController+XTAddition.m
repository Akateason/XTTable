//
//  UIAlertController+XTAddition.m
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UIAlertController+XTAddition.h"
#import "UIViewController+XTAddition.h"
#import "CommonFunc.h"

@implementation UIAlertController (XTAddition)

+ (void)xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                                title:(NSString *)title
                                              message:(NSString *)message
                                    cancelButtonTitle:(NSString *)cancelBtnTitle
                               destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                    otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                         fromWithView:(UIView *)fromView
                                        CallBackBlock:(void (^)(NSInteger btnIndex))block {
    
    UIViewController *rootCtrller = [UIViewController xt_topViewController];
    [self xt_showAlertCntrollerWithViewController:rootCtrller alertControllerStyle:alertControllerStyle title:title message:message cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:otherBtnTitles fromWithView:fromView CallBackBlock:block] ;
}

+ (void)xt_showAlertCntrollerWithViewController:(UIViewController *)viewController
                           alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                          title:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelBtnTitle
                         destructiveButtonTitle:(NSString *)destructiveBtnTitle
                              otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                   fromWithView:(UIView *)fromView
                                  CallBackBlock:(void (^)(NSInteger btnIndex))block {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle];
    if (cancelBtnTitle.length) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            block(0);
        }];
        [alertController addAction:cancelAction];
    }

    if (otherBtnTitles.count) {
        int oldIdx = (cancelBtnTitle != nil);
        [otherBtnTitles enumerateObjectsUsingBlock:^(NSString *_Nonnull otherTitleStr, NSUInteger idx, BOOL *_Nonnull stop) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitleStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                block(oldIdx + idx);
            }];
            [alertController addAction:otherAction];
        }];
    }

    if (destructiveBtnTitle.length) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
            block(otherBtnTitles.count + (cancelBtnTitle != nil));
        }];
        [alertController addAction:destructiveAction];
    }

    if ([CommonFunc getIsIpad]) {
        alertController.popoverPresentationController.sourceView = fromView;
        alertController.popoverPresentationController.sourceRect = fromView.bounds;
        alertController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


+ (void)xt_showAlertCntrollerWithViewController:(UIViewController *)viewController
                           alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                          title:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelBtnTitle
                         destructiveButtonTitle:(NSString *)destructiveBtnTitle
                              otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                  CallBackBlock:(void (^)(NSInteger btnIndex))block {
    [self xt_showAlertCntrollerWithViewController:viewController alertControllerStyle:alertControllerStyle title:title message:message cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:otherBtnTitles fromWithView:nil CallBackBlock:block] ;
}

+ (void)xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                                title:(NSString *)title
                                              message:(NSString *)message
                                    cancelButtonTitle:(NSString *)cancelBtnTitle
                               destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                    otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                        callBackBlock:(void (^)(NSInteger btnIndex))block {
    UIViewController *rootCtrller = [UIViewController xt_topViewController];
    [self xt_showAlertCntrollerWithViewController:rootCtrller alertControllerStyle:alertControllerStyle title:title message:message cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:otherBtnTitles CallBackBlock:block];
}


+ (void)xt_showTextFieldAlertWithTitle:(NSString *)title
                              subtitle:(NSString *)subTitle
                                cancel:(NSString *)cancelStr
                                commit:(NSString *)commitStr
                           placeHolder:(NSString *)placeHolderStr
                              callback:(void (^)(BOOL isConfirm, NSString *text))textBlock {
    [self xt_showTextFieldAlertWithTitle:title subtitle:subTitle cancel:cancelStr commit:commitStr placeHolder:placeHolderStr fromWithView:nil callback:textBlock] ;
}



+ (void)xt_showTextFieldAlertWithTitle:(NSString *)title
                              subtitle:(NSString *)subTitle
                                cancel:(NSString *)cancelStr
                                commit:(NSString *)commitStr
                           placeHolder:(NSString *)placeHolderStr
                          fromWithView:(UIView *)fromView
                              callback:(void (^)(BOOL isConfirm, NSString *text))textBlock {
    
    UIViewController *rootCtrller = [UIViewController xt_topViewController];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:subTitle
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (cancelStr.length) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
            textBlock(NO, nil) ;
        }];
        [alert addAction:cancelAction];
    }

    if (commitStr.length) {
        UIAlertAction *submit = [UIAlertAction actionWithTitle:commitStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            if (alert.textFields.count > 0) {
                UITextField *textField = [alert.textFields firstObject];
                if (textBlock) textBlock(YES, textField.text) ;
            }
        }];
        [alert addAction:submit];
    }

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeHolderStr; // if needs
    }];
    
    if ([CommonFunc getIsIpad]) {
        alert.popoverPresentationController.sourceView = fromView;
        alert.popoverPresentationController.sourceRect = fromView.bounds;
        alert.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [rootCtrller presentViewController:alert animated:YES completion:nil];
}

@end

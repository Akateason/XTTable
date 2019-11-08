//
//  XTTextField.h
//  XTBase
//
//  Created by teason23 on 2018/12/5.
//  Copyright © 2018 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class XTTextField;

@protocol XTTextFieldDelegate <NSObject>
@optional
- (CGFloat)xt_textfieldFlexWidth ;
- (void)xt_textFieldDeleteBackward:(XTTextField *)textField ;

@end

@interface XTTextField : UITextField
@property (weak, nonatomic) id <XTTextFieldDelegate> xt_delegate ;
@end

NS_ASSUME_NONNULL_END

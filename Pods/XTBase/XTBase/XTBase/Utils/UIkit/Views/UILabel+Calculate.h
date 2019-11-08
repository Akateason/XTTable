//
//  UILabel+Calculate.h
//  XTlib
//
//  Created by teason23 on 2018/4/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Calculate)

+ (CGFloat)getLabelHeightWithText:(NSString *)text
                            width:(CGFloat)width
                             font:(CGFloat)font;

+ (CGFloat)getLabelWidthWithText:(NSString *)text
                          height:(CGFloat)height
                            font:(CGFloat)font;

- (CGFloat)caculateHeightWithWidth:(CGFloat)width;

- (CGFloat)caculateWidthWithHeight:(CGFloat)height;

@end

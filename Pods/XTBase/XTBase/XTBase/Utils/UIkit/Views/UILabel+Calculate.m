//
//  UILabel+Calculate.m
//  XTlib
//
//  Created by teason23 on 2018/4/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UILabel+Calculate.h"


@implementation UILabel (Calculate)

//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text
                            width:(CGFloat)width
                             font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] }
                                     context:nil];
    return rect.size.height;
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getLabelWidthWithText:(NSString *)text
                          height:(CGFloat)height
                            font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] }
                                     context:nil];
    return rect.size.width;
}


- (CGFloat)caculateHeightWithWidth:(CGFloat)width {
    return [[self class] getLabelHeightWithText:self.text
                                          width:width
                                           font:self.font.pointSize];
}


- (CGFloat)caculateWidthWithHeight:(CGFloat)height {
    return [[self class] getLabelWidthWithText:self.text
                                        height:height
                                          font:self.font.pointSize];
}

@end

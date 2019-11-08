//
//  UIButton+XT.h
//  XTlib
//
//  Created by teason23 on 2018/11/1.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (XT)

@end

static const float kDefaultEnlargeFlex = 25.;


@interface UIButton (ExtendTouchRect)
@property (assign, nonatomic) UIEdgeInsets touchExtendInset;

// enlarge e.g. UIEdgeInsetsMake(-15, -15, -15, -15) ;
- (void)xt_enlargeButtonsTouchArea;
@end


@interface UIButton (Countdown)
/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)xt_startWithTime:(NSInteger)timeLine
                   title:(NSString *)title
          countDownTitle:(NSString *)subTitle
               mainColor:(UIColor *)mColor
              countColor:(UIColor *)color;
@end


typedef NS_ENUM(NSInteger, XTBtImagePosition) {
    XTBtImagePositionLeft   = 0, //图片在左，文字在右，默认
    XTBtImagePositionRight  = 1, //图片在右，文字在左
    XTBtImagePositionTop    = 2, //图片在上，文字在下
    XTBtImagePositionBottom = 3, //图片在下，文字在上
};


@interface UIButton (XTImagePosition)
- (void)xt_setImagePosition:(XTBtImagePosition)postion
                    spacing:(CGFloat)spacing;
@end


NS_ASSUME_NONNULL_END

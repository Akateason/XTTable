//
//  UILabel+Addition.h
//  StepsTracker
//
//  Created by teason23 on 2018/6/5.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Addition)

- (UILabel *)xt_withDigitalAttributedText:(NSString *)text
                              normalColor:(UIColor *)nc
                               normalFont:(UIFont *)nf
                           highlightColor:(UIColor *)hc
                            highlightFont:(UIFont *)hf;

@end

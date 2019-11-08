//
//  UILabel+Addition.m
//  StepsTracker
//
//  Created by teason23 on 2018/6/5.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UILabel+Addition.h"


@implementation UILabel (Addition)

- (UILabel *)xt_withDigitalAttributedText:(NSString *)text
                              normalColor:(UIColor *)nc
                               normalFont:(UIFont *)nf
                           highlightColor:(UIColor *)hc
                            highlightFont:(UIFont *)hf {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRegularExpression *reg                   = [[NSRegularExpression alloc] initWithPattern:@"[0-9]+\\.?[0-9]*" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultArr                         = [reg matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    self.font                                  = nf;
    self.textColor                             = nc;

    for (NSTextCheckingResult *result in resultArr) {
        [attributeString addAttribute:NSForegroundColorAttributeName value:hc range:result.range];
        [attributeString addAttribute:NSFontAttributeName value:hf range:result.range];
    }
    self.attributedText = attributeString;

    return self;
}

@end

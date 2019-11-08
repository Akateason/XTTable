//
//  XTTextField.m
//  XTBase
//
//  Created by teason23 on 2018/12/5.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "XTTextField.h"

@implementation XTTextField

#pragma mark - textRects flex
- (float)myFlex {
    if (self.xt_delegate && [self.xt_delegate respondsToSelector:@selector(xt_textfieldFlexWidth)]) {
        return self.xt_delegate.xt_textfieldFlexWidth ;
    }
    return 0 ;
}
#define FLEX_WIDTHS     self.myFlex
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}

#pragma mark - back button click
- (void)deleteBackward {
    [super deleteBackward];
    
    if ([self.xt_delegate respondsToSelector:@selector(xt_textFieldDeleteBackward:)]) {
        [self.xt_delegate xt_textFieldDeleteBackward:self];
    }
}


@end

//
//  UITextView+XT.h
//  XTBase
//
//  Created by teason23 on 2019/3/14.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (XT)

- (CGRect)xt_frameOfTextRange:(NSRange)range ;
- (void)xt_enumarateThroughParagraphsInRange:(NSRange)range
                                   withBlock:(void (^)(NSRange paragraphRange))block ;


@end

NS_ASSUME_NONNULL_END

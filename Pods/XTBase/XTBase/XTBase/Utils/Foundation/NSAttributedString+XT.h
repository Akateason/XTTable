//
//  NSAttributedString+XT.h
//  XTBase
//
//  Created by teason23 on 2019/3/14.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (XT)

- (NSRange)xt_firstParagraphRangeFromTextRange:(NSRange)range ;

- (NSArray *)xt_rangeOfParagraphsFromTextRange:(NSRange)textRange ;

@end

NS_ASSUME_NONNULL_END

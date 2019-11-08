//
//  UITextView+XT.m
//  XTBase
//
//  Created by teason23 on 2019/3/14.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "UITextView+XT.h"
#import "NSAttributedString+XT.h"


@implementation UITextView (XT)

- (CGRect)xt_frameOfTextRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:start toPosition:end];
    
    NSArray *selectionRects     = [self selectionRectsForRange:selectionRange];
    CGRect completeRect         = CGRectNull;
    
    for (UITextSelectionRect *selectionRect in selectionRects) {
        completeRect = (CGRectIsNull(completeRect)) ? selectionRect.rect : CGRectUnion(completeRect, selectionRect.rect);
    }
    
    return completeRect;
}

- (void)xt_enumarateThroughParagraphsInRange:(NSRange)range withBlock:(void (^)(NSRange paragraphRange))block {
    if (![self hasText])
        return;
    
    NSArray *rangeOfParagraphsInSelectedText = [self.attributedText xt_rangeOfParagraphsFromTextRange:self.selectedRange];
    
    for (int i = 0; i < rangeOfParagraphsInSelectedText.count; i++) {
        NSValue *value         = [rangeOfParagraphsInSelectedText objectAtIndex:i];
        NSRange paragraphRange = [value rangeValue];
        block(paragraphRange);
    }
    
    NSRange fullRange = [self xt_fullRangeFromArrayOfParagraphRanges:rangeOfParagraphsInSelectedText];
    [self setSelectedRange:fullRange];
}

- (NSRange)xt_fullRangeFromArrayOfParagraphRanges:(NSArray *)paragraphRanges {
    if (!paragraphRanges.count)
        return NSMakeRange(0, 0);
    
    NSRange firstRange = [[paragraphRanges objectAtIndex:0] rangeValue];
    NSRange lastRange  = [[paragraphRanges lastObject] rangeValue];
    return NSMakeRange(firstRange.location, lastRange.location + lastRange.length - firstRange.location);
}

- (UIFont *)xt_fontAtIndex:(NSInteger)index {
    // If index at end of string, get attributes starting from previous character
    if (index == self.attributedText.string.length && [self hasText])
        --index;
    
    // If no text exists get font from typing attributes
    NSDictionary *dictionary = ([self hasText]) ? [self.attributedText attributesAtIndex:index effectiveRange:nil] : self.typingAttributes;
    
    return [dictionary objectForKey:NSFontAttributeName];
}

- (NSDictionary *)xt_dictionaryAtIndex:(NSInteger)index {
    // If index at end of string, get attributes starting from previous character
    if (index == self.attributedText.string.length && [self hasText])
        --index;
    
    // If no text exists get font from typing attributes
    return ([self hasText]) ? [self.attributedText attributesAtIndex:index effectiveRange:nil] : self.typingAttributes;
}



@end

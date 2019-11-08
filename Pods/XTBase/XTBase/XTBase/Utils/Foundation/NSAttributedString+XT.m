//
//  NSAttributedString+XT.m
//  XTBase
//
//  Created by teason23 on 2019/3/14.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "NSAttributedString+XT.h"

@implementation NSAttributedString (XT)

- (NSRange)xt_firstParagraphRangeFromTextRange:(NSRange)range {
    NSInteger start  = -1;
    NSInteger end    = -1;
    NSInteger length = 0;
    
    NSInteger startingRange = (range.location == self.string.length || [self.string characterAtIndex:range.location] == '\n') ?
    range.location - 1 :
    range.location;
    
    for (int i = startingRange; i >= 0; i--) {
        char c = [self.string characterAtIndex:i];
        if (c == '\n') {
            start = i + 1;
            break;
        }
    }
    
    start = (start == -1) ? 0 : start;
    
    NSInteger moveForwardIndex = (range.location > start) ? range.location : start;
    
    for (int i = moveForwardIndex; i <= self.string.length - 1; i++) {
        char c = [self.string characterAtIndex:i];
        if (c == '\n') {
            end = i;
            break;
        }
    }
    
    end    = (end == -1) ? self.string.length : end;
    length = end - start;
    
    return NSMakeRange(start, length);
}

- (NSArray *)xt_rangeOfParagraphsFromTextRange:(NSRange)textRange {
    NSMutableArray *paragraphRanges = [NSMutableArray array];
    NSInteger rangeStartIndex       = textRange.location;
    
    while (true) {
        NSRange range   = [self xt_firstParagraphRangeFromTextRange:NSMakeRange(rangeStartIndex, 0)];
        rangeStartIndex = range.location + range.length + 1;
        
        [paragraphRanges addObject:[NSValue valueWithRange:range]];
        
        if (range.location + range.length >= textRange.location + textRange.length)
            break;
    }
    
    return paragraphRanges;
}



@end

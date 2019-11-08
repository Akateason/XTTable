//
//  NSNumber+Round.m
//  PatchBoard
//
//  Created by teason23 on 2017/8/23.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "NSNumber+Round.h"


@implementation NSNumber (Round)

- (NSNumber *)xt_doRoundWithDigit:(NSUInteger)digit {
    NSNumber *result             = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    result = [NSNumber numberWithFloat:[[formatter stringFromNumber:self] floatValue]];
    return result;
}

@end

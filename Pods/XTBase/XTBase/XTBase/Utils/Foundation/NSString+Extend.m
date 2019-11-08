//
//  NSString+Extend.m
//  SuBaoJiang
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "NSString+Extend.h"
#import "NSDate+XTTick.h"
#import "FastCodeHeader.h"


@implementation NSString (Extend)


/**
 *  URLEncode
 */
- (NSString *)URLEncodedString {
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";

    NSString *unencodedString = self;
    NSString *encodedString   = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)unencodedString,
                                                                  NULL,
                                                                  (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                  kCFStringEncodingUTF8));

    return encodedString;
}

- (NSString *)URLDecodedString {
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];

    NSString *encodedString = self;
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                    (__bridge CFStringRef)encodedString,
                                                                                                                    CFSTR(""),
                                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


// 去掉空格
- (NSString *)minusSpaceStr {
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];

    NSArray *parts         = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];

    return [filteredArray componentsJoinedByString:@" "];
}

// 去掉换行
- (NSString *)minusReturnStr {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content           = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content           = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    return content;
}


static NSString *const kSingleQuotes = @"&SingleQuotes&";

// 转义单引号  '  -> \'
- (NSString *)encodeTransferredMeaningForSingleQuotes {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content           = [content stringByReplacingOccurrencesOfString:@"\'" withString:kSingleQuotes];
    NSLog(@"content : %@", content);
    return content;
}

// 转义单引号  \' -> '
- (NSString *)decodeTransferredMeaningForSingleQuotes {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content           = [content stringByReplacingOccurrencesOfString:kSingleQuotes withString:@"\'"];
    return content;
}

// 去掉小数点后面的0
+ (NSString *)changeFloat:(NSString *)stringFloat {
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length      = [stringFloat length];
    NSUInteger zeroLength  = 0;
    NSInteger i            = length - 1;
    for (; i >= 0; i--) {
        if (floatChars[i] == '0' /*0x30*/) {
            zeroLength++;
        }
        else {
            if (floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if (i == -1) {
        returnString = @"0";
    }
    else {
        returnString = [stringFloat substringToIndex:i + 1];
    }
    return returnString;
}

// 数组切换','字符串
+ (NSString *)getCommaStringWithArray:(NSArray *)array {
    NSString *strResult = @"";

    for (int i = 0; i < array.count; i++) {
        if (i == array.count - 1) {
            NSString *tempStr = [NSString stringWithFormat:@"%@", array[i]];
            strResult         = [strResult stringByAppendingString:tempStr];
        }
        else {
            NSString *tempStr = [NSString stringWithFormat:@"%@,", array[i]];
            strResult         = [strResult stringByAppendingString:tempStr];
        }
    }

    return strResult;
}

+ (NSArray *)getArrayFromCommaString:(NSString *)commaStr {
    return [commaStr componentsSeparatedByString:@","];
}

// 随机字符串
+ (NSString *)getUniqueString {
    return [self getUniqueStringWithLength:10];
}

+ (NSString *)getUniqueStringWithLength:(int)length {
    NSString *str = STR_FORMAT(@"%@%lld", [self getRandomStrWithLength:length], [NSDate xt_getNowTick]);
    return str;
}

+ (NSString *)getRandomStrWithLength:(int)length {
    NSString *strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *result = [[NSMutableString alloc] initWithCapacity:length];
    for (int i = 0; i < length; i++) {
        NSInteger index = arc4random() % (strAll.length - 1);
        char tempStr    = [strAll characterAtIndex:index];
        result          = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c", tempStr]];
    }

    return result;
}



- (NSArray <NSValue *> *)xt_searchAllRangesWithText:(NSString *)findText {
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3] ;
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [self rangeOfString:findText]; //获取第一次出现的range
    if (rang.location != NSNotFound && rang.length != 0){
        [arrayRanges addObject:[NSValue valueWithRange:rang]] ; //将第一次的加入到数组中
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0; ; i++){
            if (0 == i) {
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length ;
                rang1 = NSMakeRange(location, length);
            }
            else {
                location = rang1.location + rang1.length;
                length = self.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            //在一个range范围内查找另一个字符串的range
            rang1 = [self rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) break ;
            //添加符合条件的location进数组
            else [arrayRanges addObject:[NSValue valueWithRange:rang1]] ;
        }
        return arrayRanges ;
    }
    return nil ;
}


@end

//
//  NSString+Extend.h
//  SuBaoJiang
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Extend)
/**
 *  URLEncode Decode
 */
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

// 去除空格.
- (NSString *)minusSpaceStr;
// 去掉换行
- (NSString *)minusReturnStr;
// 转义单引号  '  -> \'
- (NSString *)encodeTransferredMeaningForSingleQuotes;
// 转义单引号  \' -> '
- (NSString *)decodeTransferredMeaningForSingleQuotes;
// 去掉小数点后面的0
+ (NSString *)changeFloat:(NSString *)stringFloat;
// 数组切换','字符串(逗号分隔)
+ (NSString *)getCommaStringWithArray:(NSArray *)array;
+ (NSArray *)getArrayFromCommaString:(NSString *)commaStr;
// 随机字符串
+ (NSString *)getUniqueString;
+ (NSString *)getUniqueStringWithLength:(int)length;
+ (NSString *)getRandomStrWithLength:(int)length;
// 某个字符串中, 出现了几次相同的字符串.
- (NSArray <NSValue *> *)xt_searchAllRangesWithText:(NSString *)findText ;

@end

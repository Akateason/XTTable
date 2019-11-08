//
//  NSDate+XTTick.m
//  XTkit
//
//  Created by teason23 on 2017/5/9.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "NSDate+XTTick.h"


@implementation NSDate (XTTick)

/**
 get Tick
 */
+ (long long)xt_getNowTick {
    return [[NSDate date] xt_getTick];
}

- (long long)xt_getTick {
    NSTimeInterval timeInterval2 = [self timeIntervalSince1970];
    long long time               = (long long)((double)timeInterval2 * kUnitConversion);
    //    NSLog(@"xt_tick :%lld",time) ;
    return time;
}

+ (long long)xt_getTickWithDateStr:(NSString *)dateStr
                            format:(NSString *)format {
    return [[self xt_getDateWithStr:dateStr format:format] xt_getTick];
}

/**
 compare tick
 */
+ (NSComparisonResult)xt_compareTick:(long long)tick1
                                 and:(long long)tick2 {
    NSDate *date1 = [NSDate xt_getDateWithTick:tick1];
    NSDate *date2 = [NSDate xt_getDateWithTick:tick2];
    return [date1 compare:date2];
}

/**
 get time str
 */
+ (NSString *)xt_getStrWithTick:(long long)tick {
    return [self xt_getStrWithTick:tick
                            format:kTIME_STR_FORMAT_1];
}

+ (NSString *)xt_getStrWithTick:(long long)tick
                         format:(NSString *)format {
    NSTimeInterval timeInterval = (double)tick / kUnitConversion;
    NSDate *theDate             = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [theDate xt_getStrWithFormat:format];
}

- (NSString *)xt_getStr {
    return [self xt_getStrWithFormat:kTIME_STR_FORMAT_1];
}

- (NSString *)xt_getStrWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

- (NSString *)xt_timeInfo {
    // 把日期字符串格式化为日期对象
    NSDate *curDate     = [NSDate date];
    NSTimeInterval time = -[self timeIntervalSinceDate:curDate];
    //    NSLog(@"[curDate getYear] : %d",[curDate getYear]) ;
    //    NSLog(@"[date getYear] : %d",[date getYear]) ;
    //    NSLog(@"[curDate getMonth] : %d",[curDate getMonth]) ;
    //    NSLog(@"[date getMonth] : %d",[date getMonth]) ;
    //    NSLog(@"[curDate getDay] : %d",[curDate getDay]) ;
    //    NSLog(@"[date getDay] : %d",[date getDay]) ;
    //    int year = (int)([curDate getYear] - [date getYear]);
    //    int month = (int)([curDate getMonth] - [date getMonth]);
    //    int day = (int)([curDate getDay] - [date getDay]);

    NSTimeInterval retTime = 1.0;
    if (time == 0) {
        return @"";
    }
    // 小于三分钟
    else if (time < 60 * 10) {
        return @"刚刚";
    }
    // 小于一小时
    else if (time < 60 * 60) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%d分钟前", (int)retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%d小时前", (int)retTime];
    }
    // 一到七天
    else if (time < (3600 * 24) * 7) {
        retTime = time / (3600 * 24);
        return [NSString stringWithFormat:@"%d天前", (int)retTime];
    }
    // 七天到一年
    else if (time < (3600 * 24) * 365) {
        return [self xt_getMMDD];
    }
    // 一年之后
    else {
        return [self xt_getStrWithFormat:kTIME_STR_FORMAT_5];
    }


    /*
     // 昨天
     else if (time < 3600 * 24 * 2)
     {
     return @"昨天";
     }
     // 第一个条件是同年，且相隔时间在一个月内
     // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
     else if ((abs(year) == 0 && abs(month) <= 1)
     || (abs(year) == 1 && [curDate getMonth] == 1 && [date getMonth] == 12))
     {
     int retDay = 0;
     // 同年
     if (year == 0) {
     // 同月
     if (month == 0) {
     retDay = day;
     }
     }
     
     if (retDay <= 0) {
     // 这里按月最大值来计算
     // 获取发布日期中，该月总共有多少天
     int totalDays = [NSDate daysInMonth:(int)[date getMonth] year:(int)[date getYear]];
     // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
     retDay = (int)[curDate getDay] + (totalDays - (int)[date getDay]);
     
     if (retDay >= totalDays) {
     return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
     }
     }
     
     return (retDay < 4) ? [NSString stringWithFormat:@"%d天前", (abs)(retDay)] : [self getMMDDWithDate:date] ;
     
     } else  {
     if (abs(year) <= 1) {
     if (year == 0) { // 同年
     return [NSString stringWithFormat:@"%d个月前", abs(month)];
     }
     
     // 相差一年
     int month = (int)[curDate getMonth];
     int preMonth = (int)[date getMonth];
     
     // 隔年，但同月，就作为满一年来计算
     if (month == 12 && preMonth == 12) {
     return @"1年前";
     }
     
     // 也不看，但非同月
     return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
     }
     
     return [NSString stringWithFormat:@"%d年前", abs(year)];
     }
     */
    return @"";
}

- (NSString *)xt_getMMDD {
    return [self xt_getStrWithFormat:kTIME_STR_FORMAT_8];
}


/**
 get date
 */
+ (NSDate *)xt_getDateWithTick:(long long)tick {
    NSTimeInterval timeInterval = (double)tick / kUnitConversion;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSDate *)xt_getDateWithStr:(NSString *)dateStr {
    return [self xt_getDateWithStr:dateStr
                            format:kTIME_STR_FORMAT_1];
}


+ (NSDate *)xt_getDateWithStr:(NSString *)dateStr
                       format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]] ;
    dateFormatter.dateFormat = format;
    return [dateFormatter dateFromString:dateStr];
}


@end

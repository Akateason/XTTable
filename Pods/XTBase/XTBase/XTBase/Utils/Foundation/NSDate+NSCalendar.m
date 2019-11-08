//
//  NSDate+NSCalendar.m
//  XTkit
//
//  Created by teason23 on 2017/5/9.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "NSDate+NSCalendar.h"


@implementation NSDate (NSCalendar)

- (NSDateComponents *)shareComps {
    NSCalendar *calendar    = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags     = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags
                                          fromDate:self];
    return comps;
}

- (int)getYear {
    NSDateComponents *comps = [self shareComps];
    NSInteger year          = [comps year];
    return (int)year;
}

- (int)getMonth {
    NSDateComponents *comps = [self shareComps];
    NSInteger month         = [comps month];
    return (int)month;
}

- (int)getDay {
    NSDateComponents *comps = [self shareComps];
    NSInteger day           = [comps day];
    return (int)day;
}

- (int)getHour {
    NSDateComponents *comps = [self shareComps];
    NSInteger hour          = [comps hour];
    return (int)hour;
}

- (int)getMinute {
    NSDateComponents *comps = [self shareComps];
    NSInteger minute        = [comps minute];
    return (int)minute;
}

- (int)getSecond {
    NSDateComponents *comps = [self shareComps];
    NSInteger second        = [comps second];
    return (int)second;
}

+ (int)daysInMonth:(int)imonth year:(int)year {
    if ((imonth == 1) || (imonth == 3) || (imonth == 5) || (imonth == 7) || (imonth == 8) || (imonth == 10) || (imonth == 12)) return 31;
    if ((imonth == 4) || (imonth == 6) || (imonth == 9) || (imonth == 11)) return 30;
    if ((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)) return 28;
    if (year % 400 == 0) return 29;
    if (year % 100 == 0) return 28;
    return 29;
}


@end

//
//  NSDate+NSCalendar.h
//  XTkit
//
//  Created by teason23 on 2017/5/9.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (NSCalendar)

- (int)getYear;
- (int)getMonth;
- (int)getDay;
- (int)getHour;
- (int)getMinute;
- (int)getSecond;
+ (int)daysInMonth:(int)imonth
              year:(int)year;

@end

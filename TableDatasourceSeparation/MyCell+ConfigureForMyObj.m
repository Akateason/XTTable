//
//  MyCell+ConfigureForMyObj.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MyCell+ConfigureForMyObj.h"

@implementation MyCell (ConfigureForMyObj)

- (void)configureForMyObj:(MyObj *)myObj
{
    self.lbTitle.text = myObj.name;
    self.lbDate.text = [self.dateFormatter stringFromDate:myObj.creationDate];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    return dateFormatter;
}

@end

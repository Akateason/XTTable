//
//  MyCell.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)configureForCustomObj:(id)obj ;
{
    MyObj *myObj = (MyObj *)obj ;
    self.lbTitle.text = myObj.name ;
    self.lbDate.text = [NSString stringWithFormat:@"%@", myObj.creationDate] ;
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
{
    return 72.0f ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

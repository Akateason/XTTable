//
//  MyCell.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    MyObj *myObj = (MyObj *)obj ;
    MyCell *mycell = (MyCell *)cell ;
    mycell.lbTitle.text = myObj.name ;
    mycell.lbHeight.text = [NSString stringWithFormat:@"my Height is : %@", @(myObj.height)] ;
    cell.backgroundColor = indexPath.row % 2 ? [UIColor greenColor] : [UIColor brownColor] ;
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((MyObj *)obj).height ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

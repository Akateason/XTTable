//
//  MyCell.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MyCell.h"
#import "XTTable.h"


@implementation MyCell

- (void)xt_configure:(id)model indexPath:(NSIndexPath *)indexPath {
    [super xt_configure:model indexPath:indexPath] ;
    
    MyObj *myObj         = (MyObj *)model;
    _lbTitle.text  = myObj.name;
    _lbHeight.text = [NSString stringWithFormat:@"my Height is : %@", @(myObj.height)];
    self.backgroundColor = indexPath.row % 2 ? [UIColor greenColor] : [UIColor brownColor];
}

+ (CGFloat)xt_cellHeightForModel:(id)model {
    return ((MyObj *)model).height;
}


@end

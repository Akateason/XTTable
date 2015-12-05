//
//  XTRootCustomCell.m
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTRootCustomCell.h"

@implementation XTRootCustomCell

+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

- (void)configureForCustomObj:(id)obj ;
{
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
{
    if (!obj) {
        return 0.0f ; // if obj is null .
    }
    
    return 44.0f ; // default height
}

@end

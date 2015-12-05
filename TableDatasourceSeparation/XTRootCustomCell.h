//
//  XTRootCustomCell.h
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTRootCustomCell : UITableViewCell

+ (UINib *)nibWithIdentifier:(NSString *)identifier ;
- (void)configureForCustomObj:(id)obj ;
+ (CGFloat)getCellHeightWithCustomObj:(id)obj ;

@end

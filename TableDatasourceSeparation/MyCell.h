//
//  MyCell.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyCell : UITableViewCell

+ (UINib *)nibWithIdentifier:(NSString *)identifier ;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@end

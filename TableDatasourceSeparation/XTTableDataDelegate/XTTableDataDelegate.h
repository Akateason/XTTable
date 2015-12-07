//
//  XTTableDataDelegate.h
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XTRootCustomCell ;

typedef void    (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, XTRootCustomCell *cell) ;
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
typedef void    (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;

@interface XTTableDataDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end
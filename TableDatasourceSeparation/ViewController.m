//
//  ViewController.m
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "XTTableDataDelegate.h"
#import "MyCell.h"
#import "MyObj.h"
#import "UITableViewCell+Extension.h"

static NSString *const MyCellIdentifier = @"MyCell" ; // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *list ;
@property (nonatomic,strong) XTTableDataDelegate *tableHandler ;

@end

@implementation ViewController

- (NSMutableArray *)list
{
    if (!_list)
    {
        _list = [@[] mutableCopy] ;
        for (int i = 0; i < 10; i++)
        {
            MyObj *obj = [[MyObj alloc] init] ;
            obj.name = [NSString stringWithFormat:@"my name is : %d",i] ;
            obj.height = 50 + i * 5 ;
            [_list addObject:obj] ;
        }
    }
    return _list ;
}

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    [self setupTableView] ;
}

- (void)setupTableView
{
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;

    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, MyObj *obj, UITableViewCell *cell) {
        [cell configure:cell
              customObj:obj
              indexPath:indexPath] ;
    } ;
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [MyCell getCellHeightWithCustomObj:item
                                        indexPath:indexPath] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
    } ;
    
    self.tableHandler = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                   cellIdentifier:MyCellIdentifier
                                               configureCellBlock:configureCell
                                                  cellHeightBlock:heightBlock
                                                   didSelectBlock:selectedBlock] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.table] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

static NSString *const MyCellIdentifier = @"MyCell" ;

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *list ;
@property (nonatomic,strong) XTTableDataDelegate *tableHander ;

@end

@implementation ViewController

- (NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array] ;
        
        for (int i = 0; i < 10; i++)
        {
            MyObj *obj = [[MyObj alloc] init] ;
            obj.name = [NSString stringWithFormat:@"hehe%d",i] ;
            obj.creationDate = [NSDate date] ;
            [_list addObject:obj] ;
        }
    }
    
    return _list ;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    [self setupTableView] ;
}

- (void)setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(MyCell *cell, MyObj *myobj) {
        [cell configureForCustomObj:myobj] ;
    } ;
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [MyCell getCellHeightWithCustomObj:item] ;
    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
    } ;
    
    self.tableHander = [[XTTableDataDelegate alloc] initWithItems:self.list
                                                   cellIdentifier:MyCellIdentifier
                                               configureCellBlock:configureCell
                                                  cellHeightBlock:heightBlock
                                                   didSelectBlock:selectedBlock] ;

    [self.tableHander handleTableViewDatasourceAndDelegate:self.table] ;
    
    [self.table registerNib:[MyCell nibWithIdentifier:MyCellIdentifier]
     forCellReuseIdentifier:MyCellIdentifier] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

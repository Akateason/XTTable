//
//  ViewController.m
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "DatasourceHandler.h"
#import "MyCell.h"
#import "MyCell+ConfigureForMyObj.h"
#import "MyObj.h"

static NSString *const MyCellIdentifier = @"MyCell" ;

@interface ViewController () <UITableViewDelegate>
@property (nonatomic,strong) DatasourceHandler *tableHander ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView] ;
}

- (void)setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(MyCell *cell, MyObj *myobj) {
        [cell configureForMyObj:myobj];
    };
    
    NSMutableArray *list = [[NSMutableArray alloc] init] ;
    for (int i = 0; i < 10; i++)
    {
        MyObj *obj = [[MyObj alloc] init] ;
        obj.name = [NSString stringWithFormat:@"hehe%d",i] ;
        obj.creationDate = [NSDate date] ;
        [list addObject:obj] ;
    }
    
    self.tableHander = [[DatasourceHandler alloc] initWithItems:list
                                                 cellIdentifier:MyCellIdentifier
                                             configureCellBlock:configureCell] ;
    
    self.table.dataSource = self.tableHander;
    self.table.delegate = self ;
    [self.table registerNib:[MyCell nibWithIdentifier:MyCellIdentifier]
     forCellReuseIdentifier:MyCellIdentifier];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click") ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

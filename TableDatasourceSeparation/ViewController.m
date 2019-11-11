//
//  ViewController.m
//  TableDatasourceSeparation
//
//  Created by TuTu on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MyObj.h"
#import "XTTable.h"



@interface ViewController () <UITableViewXTReloaderDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *list;


@end


@implementation ViewController

- (NSArray *)list {
    if (!_list) {
        NSMutableArray *tmplist = [@[] mutableCopy];
        for (int i = 0; i < 10; i++) {
            MyObj *obj = [[MyObj alloc] init];
            obj.name   = [NSString stringWithFormat:@"my name is : %d", i];
            obj.height = 50 + i * 5;
            [tmplist addObject:obj];
        }
        _list = tmplist ;
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    
    [MyCell xt_registerNibFromTable:self.table] ;
    [self.table xt_setup] ;
    
    self.table.delegate = self ;
    self.table.dataSource = self ;
    self.table.xt_Delegate = self ;
    
}


#pragma mark --
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [MyCell xt_fetchFromTable:tableView] ;
    [cell xt_configure:self.list[indexPath.row] indexPath:indexPath] ;
    return cell;
}

#pragma mark --
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyCell xt_cellHeightForModel:self.list[indexPath.row]] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyObj *obj = self.list[indexPath.row] ;
    NSLog(@"current index path %@, height %@",obj.name, @(obj.height)) ;
}

#pragma mark --
#pragma mark - UITableViewXTReloaderDelegate

- (void)tableView:(UITableView *)table loadNew:(void (^)(void))endRefresh {
    NSMutableArray *tmplist = [@[] mutableCopy] ;
    for (int i = 0; i < 10; i++) {
        MyObj *obj = [[MyObj alloc] init];
        obj.name   = [NSString stringWithFormat:@"下拉刷新 : %d", i];
        obj.height = 50 + i * 5;
        [tmplist addObject:obj];
    }

    [tmplist addObjectsFromArray:self.list] ;
    self.list = tmplist ;
    
    endRefresh() ;
}

- (void)tableView:(UITableView *)table loadMore:(void (^)(void))endRefresh {
    NSMutableArray *tmplist = [self.list mutableCopy] ;
    for (int i = 0; i < 10; i++) {
        MyObj *obj = [[MyObj alloc] init];
        obj.name   = [NSString stringWithFormat:@"上拉新增 : %d", i];
        obj.height = 50 + i * 5;
        [tmplist addObject:obj];
    }
    
    self.list = tmplist ;
    
    endRefresh() ;
}


@end

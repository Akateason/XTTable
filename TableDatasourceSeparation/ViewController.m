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
@property (nonatomic, copy) NSMutableArray *list;


@end


@implementation ViewController

- (NSMutableArray *)list {
    if (!_list) {
        _list = [@[] mutableCopy];
        for (int i = 0; i < 10; i++) {
            MyObj *obj = [[MyObj alloc] init];
            obj.name   = [NSString stringWithFormat:@"my name is : %d", i];
            obj.height = 50 + i * 5;
            [_list addObject:obj];
        }
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [MyCell xt_registerNibFromTable:self.table] ;
    [self.table xt_setup] ;
    
}


#pragma mark--
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCell *cell = [MyCell xt_fetchFromTable] ;
    return cell;
}

#pragma mark--
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyCell xt_cellHeight] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end

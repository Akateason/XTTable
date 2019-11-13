# XTTable

## Example

To run the example project, clone the repo, and run directory.

## Requirements

`iOS 8.0` or later

## Installation

XTTable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XTTable"
```

## Useage

### setup
```Objective-C
    [MyCell xt_registerNibFromTable:self.table] ;
    [self.table xt_setup] ;

    self.table.delegate = self ;
    self.table.dataSource = self ;
    self.table.xt_Delegate = self ;
```

### datasource and delegate
```Objective-C

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
```

### Reloader
```Objective-C
#pragma mark --
#pragma mark - UITableViewXTReloaderDelegate

- (void)tableView:(UITableView *)table loadNew:(void (^)(void))endRefresh {
    // do load new ...
    endRefresh() ;
}

- (void)tableView:(UITableView *)table loadMore:(void (^)(void))endRefresh {
    // do load more ...
    endRefresh() ;
}
```
## Author

teason, akateason@qq.com

## License

XTTable is available under the MIT license. See the LICENSE file for more info.

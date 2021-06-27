# XTTable
A tool for quickly laying out and configuring UITable and UICollectionView

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
```
#import <XTTable/XTTable.h>       // for UITableView and UITableViewCell
#import <XTTable/XTCollection.h>  // for UICollectionView and UICollectionViewCell
```
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
    return [MyCell xt_fetchFromTable:tableView] ;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell xt_configure:self.list[indexPath.row] indexPath:indexPath] ;
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

### Cell configure
```Objective-C
@implementation MyCell

- (void)xt_configure:(id)model indexPath:(NSIndexPath *)indexPath {
    [super xt_configure:model indexPath:indexPath] ;

    MyObj *myObj         = (MyObj *)model;
    _lbTitle.text  = myObj.name;
    _lbHeight.text = [NSString stringWithFormat:@"my Height is : %@", @(myObj.height)];
    self.backgroundColor = indexPath.row % 2 ? [UIColor greenColor] : [UIColor brownColor];
}

+ (CGFloat)xt_cellHeightForModel:(id)model {
    return ((MyObj *)model).height;
}

@end
```
![pic](https://github.com/Akateason/XTTable/blob/master/pic.gif)

## Author

teason, akateason@qq.com

## License

XTTable is available under the MIT license. See the LICENSE file for more info.

//
//  RootTableCell.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RootTableCell.h"
#import <objc/runtime.h>


@interface RootTableCell ()
@property (strong, nonatomic, readwrite) id model;
@end


@implementation RootTableCell

#pragma mark--
#pragma mark - util

// Register from table
+ (void)registerNibFromTable:(UITableView *)table {
    NSString *clsName = NSStringFromClass([self class]);
    [table registerNib:[UINib nibWithNibName:clsName bundle:nil] forCellReuseIdentifier:clsName];
}

+ (void)registerClsFromTable:(UITableView *)table {
    [table registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

// Fetch
+ (instancetype)fetchFromTable:(UITableView *)table {
    return [table dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)fetchFromTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    return [table dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}


#pragma mark--
#pragma mark - initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
}

#pragma mark--
#pragma mark - get cell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    @autoreleasepool {
        const char *charClsName = object_getClassName(self);
        NSString *strClsName    = [NSString stringWithUTF8String:charClsName];
        Class cellCls           = objc_getRequiredClass(charClsName);
        //  polymorphic
        RootTableCell *cell = [tableView dequeueReusableCellWithIdentifier:strClsName];
        if (!cell) {
            cell = [[cellCls alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:strClsName]; // use cls name as reuseIdentifier
        }
        return cell;
    }
}

#pragma mark--
#pragma mark - prepare UI

- (void)prepareUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark--
#pragma mark - configure

- (void)configure:(id)model {
    [self configure:model
          indexPath:nil];
}

- (void)configure:(id)model
        indexPath:(NSIndexPath *)indexPath {
    _model     = model;
    _indexPath = indexPath;
}

#pragma mark--
#pragma mark - height

+ (CGFloat)cellHeight {
    return 44.;
}
+ (CGFloat)cellHeightForModel:(id)model {
    return 44.;
}

@end

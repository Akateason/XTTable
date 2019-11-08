//
//  UITableViewCell+XT.m
//  XTlib
//
//  Created by teason23 on 2018/10/31.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UITableViewCell+XT.h"
#import <objc/runtime.h>
#import "FastCodeHeader.h"
#import "NSObject+XTRuntime.h"


@interface UITableViewCell ()
@property (strong, nonatomic, readwrite) id xt_model;
@end


@implementation UITableViewCell (XT)

ASSOCIATED(xt_model, setXt_model, id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
ASSOCIATED(xt_indexPath, setXt_indexPath, NSIndexPath *, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#pragma mark--
#pragma mark - util

// Register from table
+ (void)xt_registerNibFromTable:(UITableView *)table {
    [self xt_registerNibFromTable:table bundleOrNil:nil];
}

+ (void)xt_registerNibFromTable:(UITableView *)table bundleOrNil:(NSBundle *)bundle {
    NSString *clsName = NSStringFromClass([self class]);
    [table registerNib:[UINib nibWithNibName:clsName bundle:bundle] forCellReuseIdentifier:clsName];
}


+ (void)xt_registerClsFromTable:(UITableView *)table {
    [table registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

// Fetch
+ (instancetype)xt_fetchFromTable:(UITableView *)table {
    return [table dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)xt_fetchFromTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    return [table dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

#pragma mark--
#pragma mark - get cell

+ (instancetype)xt_cellWithTable:(UITableView *)tableView {
    @autoreleasepool {
        const char *charClsName = object_getClassName(self);
        NSString *strClsName    = [NSString stringWithUTF8String:charClsName];
        Class cellCls           = objc_getRequiredClass(charClsName);
        //  polymorphic
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strClsName];
        if (!cell) {
            cell = [[cellCls alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:strClsName]; // use cls name as reuseIdentifier
        }
        return cell;
    }
}

#pragma mark--
#pragma mark - configure

- (void)xt_configure:(id)model {
    [self xt_configure:model
             indexPath:nil];
}

- (void)xt_configure:(id)model
           indexPath:(NSIndexPath *)indexPath {
    self.xt_model     = model;
    self.xt_indexPath = indexPath;
}

#pragma mark--
#pragma mark - height

+ (CGFloat)xt_cellHeight {
    return 44.;
}
+ (CGFloat)xt_cellHeightForModel:(id)model {
    return 44.;
}

@end

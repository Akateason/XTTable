//
//  UITableView+XTPlaceHolder.m
//  XTBase
//
//  Created by teason23 on 2019/8/16.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "UITableView+XTPlaceHolder.h"
#import <objc/runtime.h>


@implementation UITableView (XTPlaceHolder)

void swizzMethod(SEL oriSel, SEL newSel) {
    
    Class class = [UITableView class];
    Method oriMethod = class_getInstanceMethod(class, oriSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL success = class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) {
        class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"xt_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        swizzMethod(originalSelector, swizzledSelector);
    }
}

- (void)xt_reloadData {
    [self xt_reloadData];
    [self showPlaceholderNotice];
}

- (void)xt_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_insertSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)xt_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_deleteSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)xt_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_reloadSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)xt_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)xt_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)xt_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self xt_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)showPlaceholderNotice {
    if (self.showNoDataNotice) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount == 0) {
            if (self.customNoDataView) {
                self.backgroundView = [self customNoDataView];
            } else
                self.backgroundView = [[UIView alloc] init];
        } else {
            self.backgroundView = [[UIView alloc] init];
        }
    }
}

#pragma mark - setter && getter
- (void)setShowNoDataNotice:(BOOL)showNoDataNotice {
    objc_setAssociatedObject(self, @selector(showNoDataNotice), @(showNoDataNotice), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showNoDataNotice {
    return objc_getAssociatedObject(self, _cmd) == nil ? YES : [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDefaultNoDataViewDidClickBlock:(void (^)(UIView *))defaultNoDataViewDidClickBlock {
    self.showNoDataNotice = YES;
    objc_setAssociatedObject(self, @selector(defaultNoDataViewDidClickBlock), defaultNoDataViewDidClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIView *))defaultNoDataViewDidClickBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCustomNoDataView:(UIView *)customNoDataView {
    self.showNoDataNotice = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(placeholderTap:)];
    [customNoDataView addGestureRecognizer:tap] ;
    objc_setAssociatedObject(self, @selector(customNoDataView), customNoDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customNoDataView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)placeholderTap:(id)gesture {
    if (self.defaultNoDataViewDidClickBlock) self.defaultNoDataViewDidClickBlock(self.customNoDataView) ;
}

@end

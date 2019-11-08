//
//  UICollectionView+XTPlaceHolder.m
//  XTBase
//
//  Created by teason23 on 2019/8/22.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "UICollectionView+XTPlaceHolder.h"
#import <objc/runtime.h>

@implementation UICollectionView (XTPlaceHolder)

static void ExchangedMethod(SEL originalSelector, SEL swizzledSelector, Class class) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



+ (void)load {
    SEL selectors[] = {
        @selector(reloadData)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"xtc_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        ExchangedMethod(originalSelector, swizzledSelector,self);
    }
}

- (void)xtc_reloadData {
    [self xtc_reloadData];
    [self showPlaceholderNotice];
}


- (void)showPlaceholderNotice {
    if (self.showNoDataNotice) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource collectionView:self numberOfItemsInSection:i] ;
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

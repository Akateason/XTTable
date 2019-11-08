//
//  UICollectionViewCell+XT.m
//  XTBase
//
//  Created by teason23 on 2018/12/11.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "UICollectionViewCell+XT.h"
#import <objc/runtime.h>
#import "FastCodeHeader.h"

@interface UICollectionViewCell ()
@property (strong, nonatomic, readwrite) id xt_model;
@end

@implementation UICollectionViewCell (XT)

ASSOCIATED(xt_model, setXt_model, id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
ASSOCIATED(xt_indexPath, setXt_indexPath, NSIndexPath *, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#pragma mark--
#pragma mark - regist
+ (void)xt_registerNibFromCollection:(UICollectionView *)collection {
    NSString *clsName = NSStringFromClass([self class]);
    [collection registerNib:[UINib nibWithNibName:clsName bundle:[NSBundle bundleForClass:self.class]] forCellWithReuseIdentifier:clsName];
}

+ (void)xt_registerClsFromCollection:(UICollectionView *)collection {
    [collection registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark--
#pragma mark - fetch reuse same name
+ (instancetype)xt_fetchFromCollection:(UICollectionView *)collection
                             indexPath:(NSIndexPath *)indexPath {
    return [collection dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

#pragma mark - rewrite in sub cls

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
#pragma mark - size

+ (CGSize)xt_cellSize {
    return CGSizeMake(50, 50);
}
+ (CGSize)xt_cellSizeForModel:(id)model {
    return CGSizeMake(50, 50);
}

@end

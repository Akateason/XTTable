//
//  RootCollectionCell.m
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "RootCollectionCell.h"
#import <objc/runtime.h>


@interface RootCollectionCell ()
@property (strong, nonatomic, readwrite) id model;
@end


@implementation RootCollectionCell

#pragma mark--
#pragma mark - initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareUI];
}

- (void)dealloc {
}


#pragma mark--
#pragma mark - regist
+ (void)registerNibFromCollection:(UICollectionView *)collection {
    NSString *clsName = NSStringFromClass([self class]);
    [collection registerNib:[UINib nibWithNibName:clsName bundle:nil] forCellWithReuseIdentifier:clsName];
}

+ (void)registerClsFromCollection:(UICollectionView *)collection {
    [collection registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark--
#pragma mark - fetch reuse same name
+ (instancetype)fetchFromCollection:(UICollectionView *)collection
                          indexPath:(NSIndexPath *)indexPath {
    return [collection dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

#pragma mark - rewrite in sub cls

#pragma mark--
#pragma mark - prepare UI

- (void)prepareUI {
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
#pragma mark - size

+ (CGSize)cellSize {
    return CGSizeMake(50, 50);
}

+ (CGSize)cellSizeForModel:(id)model {
    return CGSizeMake(50, 50);
}


@end

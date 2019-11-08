//
//  UICollectionView+XTPlaceHolder.h
//  XTBase
//
//  Created by teason23 on 2019/8/22.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (XTPlaceHolder)
/**
 默认的无数据提示 View 的点击回调
 @note 用这个 block 的时候注意在 block “内部”使用weak，不然会导致循环引用
 */
@property (nonatomic, copy) void(^defaultNoDataViewDidClickBlock)(UIView *view);

// 自定义无数据提示View
@property (nonatomic, strong) UIView *customNoDataView;
@end

NS_ASSUME_NONNULL_END

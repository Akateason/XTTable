//
//  UICollectionViewCell+XT.h
//  XTBase
//
//  Created by teason23 on 2018/12/11.
//  Copyright © 2018 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>


@interface UICollectionViewCell (XT)

@property (strong, nonatomic) NSIndexPath *xt_indexPath;
@property (strong, nonatomic, readonly) id xt_model;

#pragma mark -
// regist
+ (void)xt_registerNibFromCollection:(UICollectionView *)collection;
+ (void)xt_registerClsFromCollection:(UICollectionView *)collection;

// fetch reuse same name in pure code or storyboard or xib .
+ (instancetype)xt_fetchFromCollection:(UICollectionView *)collection
                             indexPath:(NSIndexPath *)indexPath;


#pragma mark - rewrite in sub cls

/**
 * set model rewrite in subclass
 @param model           any viewModel
 @param indexPath       indexPath for Cell
 *
 * USAGE
 *    - (void)configure:(id)model {
 *          [super configure: model] ;
 *
 *          // do configuration ...
 *    }
 *
 */
- (void)xt_configure:(id)model
           indexPath:(NSIndexPath *)indexPath;
- (void)xt_configure:(id)model;

// height
+ (CGSize)xt_cellSize;
+ (CGSize)xt_cellSizeForModel:(id)model;

@end


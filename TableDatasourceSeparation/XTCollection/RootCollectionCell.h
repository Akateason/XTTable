//
//  RootCollectionCell.h
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

__attribute__((deprecated("Class RootCollectionCell is deprecated , use UICollectionViewCell+XT instead!!!")))

@interface RootCollectionCell : UICollectionViewCell

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic, readonly) id model;

#pragma mark -
// regist
+ (void)registerNibFromCollection:(UICollectionView *)collection;
+ (void)registerClsFromCollection:(UICollectionView *)collection;

// fetch reuse same name in pure code or storyboard or xib .
+ (instancetype)fetchFromCollection:(UICollectionView *)collection
                          indexPath:(NSIndexPath *)indexPath;


#pragma mark - rewrite in sub cls
// UI and Layout
- (void)prepareUI;

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
- (void)configure:(id)model
        indexPath:(NSIndexPath *)indexPath;
- (void)configure:(id)model;

// height
+ (CGSize)cellSize;
+ (CGSize)cellSizeForModel:(id)model;

@end

//
//  UICollectionView+XT.h
//  XTBase
//
//  Created by teason23 on 2018/12/11.
//  Copyright © 2018 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UITableView+XTReloader.h"

NS_ASSUME_NONNULL_BEGIN


@protocol UICollectionViewXTReloader <NSObject>

@required
- (void)collectionView:(UICollectionView *)collection loadNew:(void (^)(void))endRefresh;
@optional
- (void)collectionView:(UICollectionView *)collection loadMore:(void (^)(void))endRefresh;

@end

@interface UICollectionView (XT)

// refresh delegate
@property (nonatomic, weak) id<UICollectionViewXTReloader> xt_Delegate;
/**
 REFRESH STYLE:
 DEFAULT IS `NO`  -> ONLY GIF IMAGES , SHOW WORDS WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL xt_isShowRefreshDetail;
/**
 is auto LOAD MORE:
 DEFAULT IS `NO`  -> MANUALLY LOADING . AUTOMATICALLY LOAD WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL xt_isAutomaticallyLoadMore;
// MJRefresh type
@property (nonatomic) XTRefreshType xt_refreshType;

// setup XT
- (void)xt_setup ;

/**
 PULL DOWN HEADER
 */
- (void)xt_loadNewInfo;
/**
 PULL DOWN HEADER
 @param isBackGround    pull header in backgound or not .
 */
- (void)xt_loadNewInfoInBackGround:(BOOL)isBackGround;
/**
 prepareStyle
 u can rewrite in subclass if needed
 */
- (void)xt_prepareStyle;
/**
 endRefresh header and footer if needed .
 */
- (void)xt_endHeaderAndFooterRefresh;
/**
 get current IndexPath in center .
 */
- (NSIndexPath *)xt_currentIndexPath;


@end

NS_ASSUME_NONNULL_END

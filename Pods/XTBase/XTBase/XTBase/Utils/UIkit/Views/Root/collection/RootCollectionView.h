//
//  RootCollectionView.h
//  XTkit
//
//  Created by xtc on 2018/2/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableView.h"

@class RootCollectionView;

__attribute__((deprecated("Class RootCollectionView is deprecated , use UICollectionView+XT instead!!!")))

@protocol RootCollectionViewDelegate <NSObject>
@required
- (void)collectionView:(RootCollectionView *)collection loadNew:(void (^)(void))endRefresh;
@optional
- (void)collectionView:(RootCollectionView *)collection loadMore:(void (^)(void))endRefresh;
@end


@interface RootCollectionView : UICollectionView
// refresh delegate
@property (nonatomic, weak) id<RootCollectionViewDelegate> xt_Delegate;
/**
 REFRESH STYLE:
 DEFAULT IS `NO`  -> ONLY GIF IMAGES , SHOW WORDS WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL isShowRefreshDetail;
/**
 is auto LOAD MORE:
 DEFAULT IS `NO`  -> MANUALLY LOADING . AUTOMATICALLY LOAD WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL isAutomaticallyLoadMore;
// MJRefresh type
@property (nonatomic) XTRefreshType refreshType;
/**
 PULL DOWN HEADER
 */
- (void)loadNewInfo;
/**
 PULL DOWN HEADER
 @param isBackGround    pull header in backgound or not .
 */
- (void)loadNewInfoInBackGround:(BOOL)isBackGround;
/**
 prepareStyle
 u can rewrite in subclass if needed
 */
- (void)prepareStyle;
/**
 endRefresh header and footer if needed .
 */
- (void)endHeaderAndFooterRefresh;
/**
 get current IndexPath in center .
 */
- (NSIndexPath *)currentIndexPath;

@end

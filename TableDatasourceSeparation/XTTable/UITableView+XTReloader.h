//
//  UITableView+XTReloader.h
//  XTlib
//
//  Created by teason23 on 2018/9/28.
//  Copyright © 2018年 teason23. All rights reserved.
//  encapsulation of MJRefresh and CYLTableViewPlaceHolder .

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UITableViewXTReloaderDelegate <NSObject>
@required
- (void)tableView:(UITableView *)table loadNew:(void (^)(void))endRefresh;
@optional
- (void)tableView:(UITableView *)table loadMore:(void (^)(void))endRefresh;
@end

typedef enum : NSUInteger {
    XTRefreshType_default,
    XTRefreshType_gifImages
} XTRefreshType;


@interface UITableView (XTReloader)
// refresh delegate
@property (nonatomic, weak) id<UITableViewXTReloaderDelegate> xt_Delegate;
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
// only table close mj header and footer
@property (nonatomic) BOOL xt_hideAllRefreshers;
// MJRefresh type
@property (nonatomic) XTRefreshType xt_refreshType;

/**
 setup XT
 */
- (void)xt_setup;

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

@end

NS_ASSUME_NONNULL_END

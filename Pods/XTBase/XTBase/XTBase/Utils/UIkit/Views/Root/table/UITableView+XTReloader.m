//
//  UITableView+XTReloader.m
//  XTlib
//
//  Created by teason23 on 2018/9/28.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UITableView+XTReloader.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"


@implementation UITableView (XTReloader)

#pragma mark--

- (void)xt_setup {
    self.estimatedRowHeight           = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    [self xt_prepareStyle];
    [self setDefaultPublicAPIs];
}

- (void)xt_prepareStyle {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configureMJRefresh];
}

- (void)configureMJRefresh {
    if (self.xt_refreshType == XTRefreshType_default) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
        self.mj_header                = header;

        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
        self.mj_footer                    = footer;
    }
    else if (self.xt_refreshType == XTRefreshType_gifImages) {
        RootRefreshHeader *header = [RootRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
        self.mj_header            = header;

        RootRefreshFooter *footer = [RootRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
        self.mj_footer            = footer;
    }
}

- (void)setDefaultPublicAPIs {
    self.xt_isShowRefreshDetail     = NO;
    self.xt_isAutomaticallyLoadMore = NO;
}

#pragma mark--
#pragma mark - Public

- (void)xt_loadNewInfo {
    [self xt_loadNewInfoInBackGround:FALSE];
}

- (void)xt_loadNewInfoInBackGround:(BOOL)isBackGround {
    if (isBackGround) {
        if (self.xt_Delegate && [self.xt_Delegate respondsToSelector:@selector(tableView:loadNew:)]) {
            __weak UITableView *weakSelf = self;
            [self.xt_Delegate tableView:self
                                loadNew:^{
                                    [weakSelf reloadTableInMainThread];
                                    [weakSelf.mj_header endRefreshing];
                                }];
        }
    }
    else {
        [self.mj_header beginRefreshing];
    }
}

#pragma mark--
#pragma mark - properties

- (id<UITableViewXTReloaderDelegate>)xt_Delegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXt_Delegate:(id<UITableViewXTReloaderDelegate>)xt_Delegate {
    objc_setAssociatedObject(self, @selector(xt_Delegate), xt_Delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xt_isShowRefreshDetail {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return value.boolValue;
}

- (void)setXt_isShowRefreshDetail:(BOOL)xt_isShowRefreshDetail {
    objc_setAssociatedObject(self, @selector(xt_isShowRefreshDetail), @(xt_isShowRefreshDetail), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if ([self.mj_header isKindOfClass:[MJRefreshStateHeader class]]) {
        ((MJRefreshStateHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.xt_isShowRefreshDetail;
        ((MJRefreshStateHeader *)self.mj_header).stateLabel.hidden           = !self.xt_isShowRefreshDetail;
        ((MJRefreshBackStateFooter *)self.mj_footer).stateLabel.hidden       = !self.xt_isShowRefreshDetail;
    }
}

- (BOOL)xt_isAutomaticallyLoadMore {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return value.boolValue;
}

- (void)setXt_isAutomaticallyLoadMore:(BOOL)xt_isAutomaticallyLoadMore {
    objc_setAssociatedObject(self, @selector(xt_isAutomaticallyLoadMore), @(xt_isAutomaticallyLoadMore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (xt_isAutomaticallyLoadMore) {
        self.mj_footer                  = nil;
        MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreDataSelector)];
        autofooter.triggerAutomaticallyRefreshPercent = 0.55;
        self.mj_footer                                = autofooter;
    }
}

- (BOOL)xt_hideAllRefreshers {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return value.boolValue;
}

- (void)setXt_hideAllRefreshers:(BOOL)xt_hideAllRefreshers {
    objc_setAssociatedObject(self, @selector(xt_hideAllRefreshers), @(xt_hideAllRefreshers), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (xt_hideAllRefreshers) {
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

- (XTRefreshType)xt_refreshType {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return [value integerValue];
}

- (void)setXt_refreshType:(XTRefreshType)xt_refreshType {
    objc_setAssociatedObject(self, @selector(xt_refreshType), @(xt_refreshType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self configureMJRefresh];
}

#pragma mark--
#pragma mark - loading methods

- (void)loadNewDataSelector {
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(tableView:loadNew:)]) {
        [self.mj_header endRefreshing];
        return;
    }

    // do request
    __weak UITableView *weakSelf = self;
    [weakSelf.xt_Delegate tableView:self
                            loadNew:^{
                                [weakSelf reloadTableInMainThread];
                                [weakSelf.mj_header endRefreshing];
                            }];
}

- (void)loadMoreDataSelector {
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(tableView:loadMore:)]) {
        [self.mj_footer endRefreshing];
        return;
    }

    // do request
    __weak UITableView *weakSelf = self;
    if (self.xt_isAutomaticallyLoadMore) {
        dispatch_async(dispatch_queue_create("refreshAutoFooter", NULL), ^{
            [weakSelf.xt_Delegate tableView:self
                                   loadMore:^{
                                       [weakSelf reloadTableInMainThread];
                                       [weakSelf.mj_footer endRefreshing];
                                   }];
        });
    }
    else {
        [weakSelf.xt_Delegate tableView:self
                               loadMore:^{
                                   [weakSelf reloadTableInMainThread];
                                   [weakSelf.mj_footer endRefreshing];
                               }];
    }
}

- (void)reloadTableInMainThread {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

- (void)xt_endHeaderAndFooterRefresh {
    [self reloadTableInMainThread];
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing];
}

@end

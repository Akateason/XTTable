//
//  RootTableView.m
//  Demo_MjRefresh
//
//  Created by teason on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "RootTableView.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"


@interface RootTableView ()

@end


@implementation RootTableView

#pragma mark--
#pragma mark - Public

- (void)loadNewInfo {
    [self loadNewInfoInBackGround:FALSE];
}

- (void)loadNewInfoInBackGround:(BOOL)isBackGround {
    if (isBackGround) {
        if (self.xt_Delegate && [self.xt_Delegate respondsToSelector:@selector(tableView:loadNew:)]) {
            __weak RootTableView *weakSelf = self;
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
#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style {
    self = [super initWithFrame:frame
                          style:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.estimatedRowHeight           = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    [self prepareStyle];
    [self setDefaultPublicAPIs];
}

- (void)prepareStyle {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configureMJRefresh];
}

- (void)configureMJRefresh {
    if (self.refreshType == XTRefreshType_default) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
        self.mj_header                = header;

        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
        self.mj_footer                    = footer;
    }
    else if (self.refreshType == XTRefreshType_gifImages) {
        RootRefreshHeader *header = [RootRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
        self.mj_header            = header;

        RootRefreshFooter *footer = [RootRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
        self.mj_footer            = footer;
    }
}

- (void)setDefaultPublicAPIs {
    self.isShowRefreshDetail     = NO;
    self.isAutomaticallyLoadMore = NO;
}

#pragma mark--
#pragma mark - Public Properties

- (void)setIsShowRefreshDetail:(BOOL)isShowRefreshDetail {
    _isShowRefreshDetail = isShowRefreshDetail;

    if ([self.mj_header isKindOfClass:[MJRefreshStateHeader class]]) {
        ((MJRefreshStateHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.isShowRefreshDetail;
        ((MJRefreshStateHeader *)self.mj_header).stateLabel.hidden           = !self.isShowRefreshDetail;
        ((MJRefreshBackStateFooter *)self.mj_footer).stateLabel.hidden       = !self.isShowRefreshDetail;
    }
}

- (void)setIsAutomaticallyLoadMore:(BOOL)isAutomaticallyLoadMore {
    _isAutomaticallyLoadMore = isAutomaticallyLoadMore;
    if (isAutomaticallyLoadMore) {
        self.mj_footer                  = nil;
        MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreDataSelector)];
        autofooter.triggerAutomaticallyRefreshPercent = 0.55;
        self.mj_footer                                = autofooter;
    }
}

- (void)setHideAllRefreshers:(BOOL)hideAllRefreshers {
    _hideAllRefreshers = hideAllRefreshers;
    if (hideAllRefreshers) {
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

- (void)setRefreshType:(XTRefreshType)refreshType {
    _refreshType = refreshType;

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
    __weak RootTableView *weakSelf = self;
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
    __weak RootTableView *weakSelf = self;
    if (self.isAutomaticallyLoadMore) {
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

- (void)endHeaderAndFooterRefresh {
    [self reloadTableInMainThread];
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

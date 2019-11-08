//
//  RootCollectionView.m
//  XTkit
//
//  Created by xtc on 2018/2/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "RootCollectionView.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"


@interface RootCollectionView ()

@end


@implementation RootCollectionView

#pragma mark--
#pragma mark - Public

- (void)loadNewInfo {
    [self loadNewInfoInBackGround:FALSE];
}

- (void)loadNewInfoInBackGround:(BOOL)isBackGround {
    if (isBackGround) {
        if (self.xt_Delegate && [self.xt_Delegate respondsToSelector:@selector(collectionView:loadNew:)]) {
            __weak RootCollectionView *weakSelf = self;
            [self.xt_Delegate collectionView:self
                                     loadNew:^{
                                         [weakSelf reloadInMainThread];
                                         [weakSelf.mj_header endRefreshing];
                                     }];
        }
    }
    else {
        [self.mj_header beginRefreshing];
    }
}

- (NSIndexPath *)currentIndexPath {
    CGRect visibleRect = (CGRect){.origin = self.contentOffset, .size = self.bounds.size};
    CGPoint visiblePoint          = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self indexPathForItemAtPoint:visiblePoint];
    return visibleIndexPath;
}

#pragma mark--
#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];
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
    [self prepareStyle];
    [self setDefaultPublicAPIs];
}

- (void)prepareStyle {
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

    ((MJRefreshStateHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.isShowRefreshDetail;
    ((MJRefreshStateHeader *)self.mj_header).stateLabel.hidden           = !self.isShowRefreshDetail;
    ((MJRefreshBackStateFooter *)self.mj_footer).stateLabel.hidden       = !self.isShowRefreshDetail;
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

- (void)setRefreshType:(XTRefreshType)refreshType {
    _refreshType = refreshType;

    [self configureMJRefresh];
}


#pragma mark--
#pragma mark - loading methods

- (void)loadNewDataSelector {
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(collectionView:loadNew:)]) {
        [self.mj_header endRefreshing];
        return;
    }

    // do request
    __weak RootCollectionView *weakSelf = self;
    [weakSelf.xt_Delegate collectionView:self
                                 loadNew:^{
                                     [weakSelf reloadInMainThread];
                                     [weakSelf.mj_header endRefreshing];
                                 }];
}

- (void)loadMoreDataSelector {
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(collectionView:loadMore:)]) {
        [self.mj_footer endRefreshing];
        return;
    }

    // do request
    __weak RootCollectionView *weakSelf = self;
    if (self.isAutomaticallyLoadMore) {
        dispatch_async(dispatch_queue_create("refreshAutoFooter", NULL), ^{
            [weakSelf.xt_Delegate collectionView:self
                                        loadMore:^{
                                            [weakSelf reloadInMainThread];
                                            [weakSelf.mj_footer endRefreshing];
                                        }];
        });
    }
    else {
        [weakSelf.xt_Delegate collectionView:self
                                    loadMore:^{
                                        [weakSelf reloadInMainThread];
                                        [weakSelf.mj_footer endRefreshing];
                                    }];
    }
}

- (void)reloadInMainThread {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

- (void)endHeaderAndFooterRefresh {
    [self reloadInMainThread];
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

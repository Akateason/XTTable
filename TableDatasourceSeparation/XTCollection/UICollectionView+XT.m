//
//  UICollectionView+XT.m
//  XTBase
//
//  Created by teason23 on 2018/12/11.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "UICollectionView+XT.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"

@implementation UICollectionView (XT)

#pragma mark--
#pragma mark - Public

- (void)xt_loadNewInfo {
    [self xt_loadNewInfoInBackGround:FALSE];
}

- (void)xt_loadNewInfoInBackGround:(BOOL)isBackGround {
    if (isBackGround) {
        if (self.xt_Delegate && [self.xt_Delegate respondsToSelector:@selector(collectionView:loadNew:)]) {
            __weak UICollectionView *weakSelf = self;
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

- (NSIndexPath *)xt_currentIndexPath {
    CGRect visibleRect = (CGRect){.origin = self.contentOffset, .size = self.bounds.size};
    CGPoint visiblePoint          = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self indexPathForItemAtPoint:visiblePoint];
    return visibleIndexPath;
}

#pragma mark--
#pragma mark - Initialization

- (void)xt_setup {
    [self xt_prepareStyle];
    [self setDefaultPublicAPIs];
}

- (void)xt_prepareStyle {
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
#pragma mark - Public Properties

- (id<UICollectionViewXTReloader>)xt_Delegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXt_Delegate:(id<UICollectionViewXTReloader>)xt_Delegate {
    objc_setAssociatedObject(self, @selector(xt_Delegate), xt_Delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xt_isShowRefreshDetail {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXt_isShowRefreshDetail:(BOOL)xt_isShowRefreshDetail {
    objc_setAssociatedObject(self, @selector(xt_isShowRefreshDetail), @(xt_isShowRefreshDetail), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    ((MJRefreshStateHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.xt_isShowRefreshDetail;
    ((MJRefreshStateHeader *)self.mj_header).stateLabel.hidden           = !self.xt_isShowRefreshDetail;
    ((MJRefreshBackStateFooter *)self.mj_footer).stateLabel.hidden       = !self.xt_isShowRefreshDetail;
}

- (BOOL)xt_isAutomaticallyLoadMore {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
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

- (XTRefreshType)xt_refreshType {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXt_refreshType:(XTRefreshType)xt_refreshType {
    objc_setAssociatedObject(self, @selector(xt_refreshType), @(xt_refreshType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
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
    __weak UICollectionView *weakSelf = self;
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
    __weak UICollectionView *weakSelf = self;
    if (self.xt_isAutomaticallyLoadMore) {
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

- (void)xt_endHeaderAndFooterRefresh {
    [self reloadInMainThread];
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing];
}

@end

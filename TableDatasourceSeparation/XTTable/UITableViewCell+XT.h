//
//  UITableViewCell+XT.h
//  XTlib
//
//  Created by teason23 on 2018/10/31.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCell (XT)

@property (strong, nonatomic) NSIndexPath *xt_indexPath;
@property (strong, nonatomic, readonly) id xt_model;

// regist
+ (void)xt_registerNibFromTable:(UITableView *)table;
+ (void)xt_registerNibFromTable:(UITableView *)table
                    bundleOrNil:(NSBundle *)bundle;

+ (void)xt_registerClsFromTable:(UITableView *)table;

// fetch reuse in storyboard or nib
+ (instancetype)xt_fetchFromTable:(UITableView *)table;
+ (instancetype)xt_fetchFromTable:(UITableView *)table
                        indexPath:(NSIndexPath *)indexPath;

// fetch in pure code way
+ (instancetype)xt_cellWithTable:(UITableView *)tableView;

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
+ (CGFloat)xt_cellHeight;
+ (CGFloat)xt_cellHeightForModel:(id)model;

@end

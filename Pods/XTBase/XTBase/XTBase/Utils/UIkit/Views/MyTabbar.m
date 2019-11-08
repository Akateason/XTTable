//
//  MyTabbar.m
//  SuBaoJiang
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "MyTabbar.h"
#import "UIImage+AddFunction.h"


@implementation MyTabbar

- (void)awakeFromNib {
    [super awakeFromNib];

    //    self.opaque = YES ;

    //    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_TABBAR_HEIGHT)] ;
    //    backView.backgroundColor = [UIColor whiteColor] ;
    //    UIView *upline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, ONE_PIXEL_VALUE)] ;
    //    upline.backgroundColor = COLOR_TABLE_SEP ;
    //    [backView addSubview:upline] ;
    //    [self insertSubview:backView atIndex:0] ;

    //    [self setClipsToBounds:YES] ;
}

//- (CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize osize = [super sizeThatFits:size];
//
//    if(osize.height < APP_TABBAR_HEIGHT) osize.height = APP_TABBAR_HEIGHT;
//    return osize;
//}

@end

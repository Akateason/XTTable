//
//  MySearchBar.m
//  JGB
//
//  Created by JGBMACMINI01 on 14-8-4.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "MySearchBar.h"
#import "UIImage+AddFunction.h"


@implementation MySearchBar

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setMyStyle];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setMyStyle];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setMyStyle {
    self.searchBarStyle = UISearchBarStyleMinimal; //UISearchBarStyleProminent       ;

    //    self.tintColor          = COLOR_MAIN            ;   //光标和取消文字的颜色

    self.barTintColor = [UIColor blackColor]; //[UIColor clearColor] ;

    UIImage *img = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 40)];
    [self setBackgroundImage:img forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

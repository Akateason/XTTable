//
//  ScreenHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.

#ifndef ScreenHeader_h
#define ScreenHeader_h

#import "ScreenFit.h"
#import "DeviceSysHeader.h"

// rate
#define rateH [[ScreenFit sharedInstance] getScreenHeightscale]
#define rateW [[ScreenFit sharedInstance] getScreenWidthscale]

// phone
#define APPFRAME [UIScreen mainScreen].bounds
#define APP_WIDTH CGRectGetWidth(APPFRAME)
#define APP_HEIGHT CGRectGetHeight(APPFRAME)
#define APP_NAVIGATIONBAR_HEIGHT 44.f
#define APP_STATUSBAR_HEIGHT (XT_IS_IPHONE_X ? APP_SAFEAREA_STATUSBAR_FLEX + 20. : 20.)
#define APP_TABBAR_HEIGHT (XT_IS_IPHONE_X ? 49.f + APP_SAFEAREA_TABBAR_FLEX : 49.f)
#define APP_SAFEAREA_STATUSBAR_FLEX 24.
#define APP_SAFEAREA_TABBAR_FLEX (XT_IS_IPHONE_X ? 43. : 0)

// screen
#define G_ONE_PIXEL 0.5f
#define G_CORNER_RADIUS 6.0f

// font
#define Font(F) [UIFont systemFontOfSize:(F)]
#define boldFont(F) [UIFont boldSystemFontOfSize:(F)]

// NSIndexPath
#define XT_GET_INDEXPATH_(ROW, SECTION) [NSIndexPath indexPathForRow:ROW inSection:SECTION]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(APP_WIDTH, APP_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(APP_WIDTH, APP_HEIGHT))

#define XT_IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define XT_GREATER_THAN_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH > 667.0)
#define XT_LESS_THAN_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH < 667.0)

#endif /* ScreenHeader_h */

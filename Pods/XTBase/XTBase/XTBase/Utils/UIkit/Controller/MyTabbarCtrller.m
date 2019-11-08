//
//  MyTabbarCtrller.m
//  SuBaoJiang
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "MyTabbarCtrller.h"
//#import "AppDelegate.h"


@interface MyTabbarCtrller ()

@end


@implementation MyTabbarCtrller

//static int indexCache = 0 ;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //        self.tabBar.tintColor = [UIColor xt_mainColor] ;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *vclist = self.viewControllers;
    for (int i = 0; i < vclist.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"item%d-s", i + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ;
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"item%d", i + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

#pragma mark--
#pragma mark - tabbar controller delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //    if ([viewController isMemberOfClass:[ShopNavCtrller class]])
    //    {
    //        [(ShopNavCtrller *)viewController pushShopCtllerFromSelectedCtrller:self.selectedViewController] ;
    //        return NO ;
    //    }

    /*
    if ([tabBarController.selectedViewController isEqual:viewController])
    {
        //double tap item in index page .
        if ([viewController isMemberOfClass:[NavIndexCtrller class]])
        {
            indexCache ++ ;
            [self performSelectorInBackground:@selector(deleteCacheIndex)
                                   withObject:nil] ;
            if (indexCache % 2 == 0)
            {
                [self.homePageDelegate doubleTapedHomePage] ;
            }
        }
        else
        {
            indexCache = 0 ;
        }
        
        return NO;
    }
    */

    /*
    if ([viewController isMemberOfClass:[MineNavCtrller class]])
    {
        if ([UserOnDevice hasLogin]) {
            return YES ;
        }
        else {
            [UserOnDevice checkForLoginOrNot:self.selectedViewController] ;
            return NO ;
        }
    }
    
    return YES;
    */
    return YES;
}

/*
- (void)deleteCacheIndex
{
    sleep(1) ;
    indexCache = 0 ;
}
*/

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"did selectedIndex %@", @(tabBarController.selectedIndex));
    [self clickItemAnimation:tabBarController];

    //  1. to camera .
    //    if (tabBarController.selectedIndex == 2) {
    //        [NavCameraCtrller jump2NavCameraCtrllerWithOriginCtrller:self.selectedViewController] ;
    //        tabBarController.selectedIndex = lastSelectedIndex ;
    //    }
    //    lastSelectedIndex = tabBarController.selectedIndex ;

    //  2. animation
}


static float kScaleSize = 1.35;
- (void)clickItemAnimation:(UITabBarController *)tabBarController {
    NSMutableArray *arrayBt = [@[] mutableCopy];
    for (id tabBt in [tabBarController.tabBar subviews])
        if ([tabBt isKindOfClass:NSClassFromString(@"UITabBarButton")])
            [arrayBt addObject:tabBt];

    NSArray *resultList = [arrayBt sortedArrayWithOptions:0
                                          usingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
                                              NSComparisonResult result = [@(obj1.frame.origin.x) compare:@(obj2.frame.origin.x)];
                                              return result == NSOrderedDescending;
                                          }];
    //    NSLog(@"resultList  : %@",resultList) ;

    UIView *selectedView = [resultList objectAtIndex:tabBarController.selectedIndex];
    int i                = 0;
    //    NSLog(@"[view subviews] : %@",[selectedView subviews]) ;

    for (id tmp in [selectedView subviews]) {
        if ([tmp isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) break;
        i++;
    }

    UIView *viewWillanimate   = [[selectedView subviews] objectAtIndex:i];
    viewWillanimate.transform = CGAffineTransformScale(viewWillanimate.transform, kScaleSize, kScaleSize);

    [UIView animateWithDuration:1.
        delay:0
        usingSpringWithDamping:0.4
        initialSpringVelocity:5.
        options:UIViewAnimationOptionAllowUserInteraction
        animations:^{

            viewWillanimate.transform = CGAffineTransformIdentity;

        }
        completion:^(BOOL finished){

        }];
}


@end

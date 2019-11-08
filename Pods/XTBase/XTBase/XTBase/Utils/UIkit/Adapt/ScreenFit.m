//
//  ScreenFit.m
//  XTkit
//
//  Created by teason23 on 2017/7/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ScreenFit.h"
#import "DeviceSysHeader.h"
#import <UIKit/UIKit.h>


@implementation ScreenFit

XT_SINGLETON_M(ScreenFit);

- (float)getScreenHeightscale {
    float scaleY   = 1.;
    float standard = 667.;
    if (iphone6) {
        scaleY = 667. / standard;
    }
    else if (iphone6plus) {
        scaleY = 736. / standard;
    }
    else if (iphone5) {
        scaleY = 568. / standard;
    }
    else if (iphone4) {
        scaleY = 480. / standard;
    }
    else {
        return 1.;
    }
    return scaleY;
}

- (float)getScreenWidthscale {
    float scaleX   = 1.;
    float standard = 375.;
    if (iphone6) {
        scaleX = 375. / standard;
    }
    else if (iphone6plus) {
        scaleX = 414. / standard;
    }
    else if (iphone5 || iphone4) {
        scaleX = 320. / standard;
    }
    else {
        scaleX = 1.;
    }
    return scaleX;
}

@end

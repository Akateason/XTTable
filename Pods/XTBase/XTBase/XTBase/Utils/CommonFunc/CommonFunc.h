//
//  CommonFunc.h
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CommonFunc : NSObject

#pragma mark - save images to library

+ (void)saveImageToLibrary:(UIImage *)savedImage complete:(void(^)(bool success))complete ;

#pragma mark - current appname / version

+ (NSString *)getAppName;

+ (NSString *)getVersionStrOfMyAPP;

+ (NSString *)getBuildVersion;

#pragma mark - update the latest version if neccessary .

//+ (void)updateLatestVersion ;

#pragma mark - give app a Score

+ (void)scoringMyAppWithAppStoreID:(NSString *)appstoreID;

#pragma mark - CLLocation  get current location

+ (CLLocationCoordinate2D)getLocation;

#pragma mark - 关闭应用

+ (void)shutDownAppWithCtrller:(UIViewController *)ctrller;

#pragma mark - 设备名
- (NSString *)getDeviceName ;
+ (BOOL)getIsIpad ;

@end

//
//  CommonFunc.m
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "CommonFunc.h"
#import "ScreenHeader.h"
#import "DeviceSysHeader.h"
#import <SDWebImage/SDImageCache.h>
#import "XTFileManager.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIImage+AddFunction.h"
#import  "sys/utsname.h"
#import <Photos/Photos.h>

#define SCORE_STR_LOW @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"
#define SCORE_STR_HIGH @"itms-apps://itunes.apple.com/app/id%@"


@implementation CommonFunc

#pragma mark-- save images to library

/**
 * 创建相册
 */
+ (void)albumWithName:(NSString *)albumName blkGetAlbum:(void(^)(PHAssetCollection *album))blkGetAlbum {
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            blkGetAlbum(collection) ;
            return ;
        }
    }
    
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
        
        blkGetAlbum([PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject) ;
    } error:nil] ;
}

+ (void)saveImageToLibrary:(UIImage *)savedImage complete:(void(^)(bool success))complete {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识 NSString *assetId =
        [PHAssetCreationRequest creationRequestForAssetFromImage:savedImage].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"保存图片到相机胶卷中失败");
            if (complete) complete(NO) ;
            return;
        }
        NSLog(@"成功保存图片到相机胶卷中");
        if (complete) complete(YES) ;
    }];
}

#pragma mark-- version

+ (NSString *)getVersionStrOfMyAPP {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"version : %@", version);
    return version;
}

+ (NSString *)getBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] ;
}

+ (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

#pragma mark--
#pragma mark - 自动更新版本

//+ (void)updateLatestVersion {
////    if (!G_BOOL_OPEN_APPSTORE) return ;
//
//    dispatch_queue_t queue = dispatch_queue_create("versionQueue", NULL) ;
//    dispatch_async(queue, ^{
//        [self checkVersionRequest] ;
//    }) ;
//}

//+ (void)checkVersionRequest {
//    NSString *versionString = [self getVersionStrOfMyAPP] ;
//
//    NSString *strUrl = @"http://itunes.apple.com/lookup?id=999705868";
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:strUrl]];
//    [request setHTTPMethod:@"POST"];
//    NSHTTPURLResponse *urlResponse = nil;
//    NSError *error = nil;
//    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
////    NSLog(@"app : %@",results) ;
//
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[results dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] ;
//
//    NSArray *infoArray = [dic objectForKey:@"results"];
//    if ([infoArray count])
//    {
//        NSDictionary *releaseInfo = [infoArray firstObject];
//        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
//
//        BOOL bNeedUpdate = ([versionString compare:lastVersion] == NSOrderedAscending) ;
//
//        if ( bNeedUpdate )
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *updateUrl = [releaseInfo objectForKey:@"trackViewUrl"] ;
//                NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"] ;
//
//                /*
//                XTSIAlertView *alertView = [[XTSIAlertView alloc] initWithTitle:@"速报酱有新版本"
//                                                                 andMessage:releaseNotes] ;
//
//                [alertView addButtonWithTitle:@"不去"
//                                         type:XTSIAlertViewButtonTypeDefault
//                                      handler:^(XTSIAlertView *alertView) {
//                                      }] ;
//                [alertView addButtonWithTitle:@"去更新了"
//                                         type:XTSIAlertViewButtonTypeDestructive
//                                      handler:^(XTSIAlertView *alertView) {
//                                          NSURL *url = [NSURL URLWithString:updateUrl];
//                                          [[UIApplication sharedApplication]openURL:url];
//                                      }] ;
//                [alertView show] ;
//                */
//            }) ;
//        }
//        else
//        {
//            NSLog(@"此版本为最新版本") ;
//        }
//    }
//}

#pragma mark - give app a Score

+ (void)scoringMyAppWithAppStoreID:(NSString *)appstoreID {
    NSString *str = IS_IOS_VERSION(7.0) ? [NSString stringWithFormat:SCORE_STR_HIGH, appstoreID] : [NSString stringWithFormat:SCORE_STR_LOW, appstoreID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


#pragma mark--
#pragma mark - CLLocation  get current location
+ (CLLocationCoordinate2D)getLocation {
    CLLocationManager *lm = [[CLLocationManager alloc] init];
    [lm setDesiredAccuracy:kCLLocationAccuracyBest];
    lm.distanceFilter = 1000.0f;
    [lm startUpdatingLocation];

    CLLocationCoordinate2D orgCoordinate;
    orgCoordinate.longitude = lm.location.coordinate.longitude;
    orgCoordinate.latitude  = lm.location.coordinate.latitude;
    [lm stopUpdatingLocation];

    return orgCoordinate;
}

#pragma mark-- 关闭应用

+ (void)shutDownAppWithCtrller:(UIViewController *)ctrller {
    [UIView animateWithDuration:0.65f animations:^{
        ctrller.view.window.alpha = 0 ;
    } completion:^(BOOL finished) {
        exit(0) ;
    }] ;
}


// 获取设备型号然后手动转化为对应名称
- (NSString *)getDeviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"美版(Global/A1901)iPhone X";

    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";

    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"]) return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5 inch (Cellular)";

    if ([deviceString isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";

    if ([deviceString isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";

    return deviceString;
}


+ (BOOL)getIsIpad {
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

@end

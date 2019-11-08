//
//  XTArchive.m
//  XTkit
//
//  Created by teason23 on 2017/7/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTArchive.h"


@implementation XTArchive

+ (void)archiveSomething:(id)something
                    path:(NSString *)path {
    BOOL success = [NSKeyedArchiver archiveRootObject:something toFile:path];
    if (success) {
        NSLog(@"xtArchive : %@\n success in path : %@", something, path);
    }
}

+ (id)unarchiveSomething:(NSString *)path {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

#pragma mark - get path

+ (NSString *)getDocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getTmpPath {
    return NSTemporaryDirectory();
}

+ (NSString *)getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getCachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getPreferencesPath {
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getApplicationResourcePath {
    return [NSBundle mainBundle].resourcePath;
}


@end


@implementation NSString (XTGetFilePath)

- (NSString *)xt_pathAppendByTrailName:(NSString *)trail {
    return [[self stringByAppendingString:@"/"] stringByAppendingString:trail];
}

@end

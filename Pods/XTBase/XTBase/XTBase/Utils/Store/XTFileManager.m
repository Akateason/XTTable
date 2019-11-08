//
//  MyFileManager.m
//  JGB
//
//  Created by teason on 14-10-29.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "XTFileManager.h"


@implementation XTFileManager

+ (BOOL)isFileExist:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (long long)getFileSize:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    return 0;
}

+ (BOOL)deleteFile:(NSString *)filePath {
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (void)savePicture:(UIImage *)picture
             atPath:(NSString *)filePath {
    NSData *data = UIImageJPEGRepresentation(picture, 1);
    [[NSFileManager defaultManager] createFileAtPath:filePath
                                            contents:data
                                          attributes:nil];
}

+ (void)createFolder:(NSString *)folderPath {
    BOOL isDirectory           = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed               = [fileManager fileExistsAtPath:folderPath
                                     isDirectory:&isDirectory];
    if (!(isDirectory == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:folderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
}

+ (void)moveFileFromPath:(NSString *)fromPath
                  toPath:(NSString *)toPath {
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}

@end

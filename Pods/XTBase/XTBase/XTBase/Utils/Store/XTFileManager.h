//
//  MyFileManager.h
//  JGB
//
//  Created by teason on 14-10-29.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//


#import <UIKit/UIkit.h>


@interface XTFileManager : NSObject

+ (BOOL)isFileExist:(NSString *)filePath;

// file or folder size
+ (long long)getFileSize:(NSString *)filePath;

+ (BOOL)deleteFile:(NSString *)filePath;

+ (void)savePicture:(UIImage *)picture
             atPath:(NSString *)filePath;

+ (void)createFolder:(NSString *)folderPath;

+ (void)moveFileFromPath:(NSString *)fromPath
                  toPath:(NSString *)toPath;

@end

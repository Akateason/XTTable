//
//  XTArchive.h
//  XTkit
//
//  Created by teason23 on 2017/7/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XT_DOCUMENTS_PATH_TRAIL_(__X__) [[XTArchive getDocumentsPath] xt_pathAppendByTrailName:__X__]
#define XT_LIBRARY_PATH_TRAIL_(__X__) [[XTArchive getLibraryPath] xt_pathAppendByTrailName:__X__]


@interface XTArchive : NSObject

#pragma mark - archiver

+ (void)archiveSomething:(id)something
                    path:(NSString *)path;

+ (id)unarchiveSomething:(NSString *)path;

#pragma mark - get path
// Documents
+ (NSString *)getDocumentsPath;
// tmp
+ (NSString *)getTmpPath;
// Library
+ (NSString *)getLibraryPath;
// Library/Caches
+ (NSString *)getCachesPath;
// Library/Preferences
+ (NSString *)getPreferencesPath;
// application
+ (NSString *)getApplicationResourcePath;
@end


@interface NSString (XTGetFilePath)
- (NSString *)xt_pathAppendByTrailName:(NSString *)trail;
@end

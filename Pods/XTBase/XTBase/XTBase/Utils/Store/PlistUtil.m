//
//  PlistUtil.m
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "PlistUtil.h"


@implementation PlistUtil

+ (NSDictionary *)dictionaryWithPlist:(NSString *)plistName {
    return [self dictionaryWithPlist:plistName bundle:[NSBundle mainBundle]] ;
}

+ (NSDictionary *)dictionaryWithPlist:(NSString *)plistName
                               bundle:(NSBundle *)bundle {
    NSString *plistPath = [bundle pathForResource:plistName ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

+ (NSArray *)arrayWithPlist:(NSString *)plistName {
    return [self arrayWithPlist:plistName bundle:[NSBundle mainBundle]] ;
}

+ (NSArray *)arrayWithPlist:(NSString *)plistName
                     bundle:(NSBundle *)bundle {
    NSString *plistPath = [bundle pathForResource:plistName ofType:@"plist"];
    return [[NSArray alloc] initWithContentsOfFile:plistPath];
}

@end

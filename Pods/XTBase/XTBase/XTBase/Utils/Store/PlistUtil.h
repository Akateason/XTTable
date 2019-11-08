//
//  PlistUtil.h
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlistUtil : NSObject

+ (NSDictionary *)dictionaryWithPlist:(NSString *)plistName;
+ (NSDictionary *)dictionaryWithPlist:(NSString *)plistName
                               bundle:(NSBundle *)bundle ;

+ (NSArray *)arrayWithPlist:(NSString *)plistName;
+ (NSArray *)arrayWithPlist:(NSString *)plistName
                     bundle:(NSBundle *)bundle ;

@end

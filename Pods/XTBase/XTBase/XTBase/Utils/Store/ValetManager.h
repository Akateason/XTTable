//
//  ValetManager.h
//  XTkit
//
//  Created by teason23 on 2017/7/26.
//  Copyright © 2017年 teason. All rights reserved.

//  keychain
//  Valet https://github.com/square/Valet

#import <Foundation/Foundation.h>
#import "FastCodeHeader.h"


@interface ValetManager : NSObject

XT_SINGLETON_H(ValetManager);

// configure first time in app launch
- (void)setup;

/**
 uname and pwd
 */
- (BOOL)saveUserName:(NSString *)name pwd:(NSString *)pwd;
- (NSString *)getPwdWithUname:(NSString *)name;
- (BOOL)removePwdWithUname:(NSString *)name;

/**
 prepareUUID
 prepare get unique UUID in Keychain when app did launching .
 @return bool success
 */
- (BOOL)prepareUUID;

/**
 get unique UUID
 */
- (NSString *)UUID;

@end

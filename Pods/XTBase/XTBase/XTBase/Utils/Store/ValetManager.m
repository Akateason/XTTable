//
//  ValetManager.m
//  XTkit
//
//  Created by teason23 on 2017/7/26.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ValetManager.h"
#import <Valet/Valet.h>
#import <UIKit/UIDevice.h>


@interface ValetManager ()
@property (strong, nonatomic) VALValet *myValet;
@end


@implementation ValetManager

XT_SINGLETON_M(ValetManager);

// configure
- (void)setup {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName            = [infoDictionary objectForKey:@"CFBundleName"];
    self.myValet                 = [[VALValet alloc] initWithIdentifier:appName
                                          accessibility:VALAccessibilityWhenUnlocked];
}

/**
 uname and pwd
 */
- (BOOL)saveUserName:(NSString *)name pwd:(NSString *)pwd {
    return [self.myValet setString:pwd forKey:name];
}

- (NSString *)getPwdWithUname:(NSString *)name {
    return [self.myValet stringForKey:name];
}

- (BOOL)removePwdWithUname:(NSString *)name {
    return [self.myValet removeObjectForKey:name];
}


/**
 prepareUUID
 prepare get unique UUID in Keychain when app did launching .
 @return bool success
 */
- (BOOL)prepareUUID {
    if ([self.myValet containsObjectForKey:@"UUID"]) return YES;
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSLog(@"uuid : %@", uuid);
    return [self.myValet setString:uuid forKey:@"UUID"];
}


/**
 get unique UUID
 */
- (NSString *)UUID {
    return [self.myValet stringForKey:@"UUID"];
}

@end

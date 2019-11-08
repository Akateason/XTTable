//
//  NSString+MD5.m
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)
- (id)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, strlen(cStr), digest); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}
@end

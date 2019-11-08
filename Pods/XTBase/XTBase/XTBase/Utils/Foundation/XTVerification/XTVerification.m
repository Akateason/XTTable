//
//  Verification.m
//  JGB
//
//  Created by JGBMACMINI01 on 14-8-25.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "XTVerification.h"


@implementation XTVerification

//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex   = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
    NSString *phoneRegex = @"^1\\d{10}$";

    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo {
    NSString *carRegex   = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    NSLog(@"carTest is %@", carTest);

    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL)validateCarType:(NSString *)CarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest   = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CarTypeRegex];

    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL)validateUserName:(NSString *)name {
    NSString *userNameRegex        = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B                         = [userNamePredicate evaluateWithObject:name];

    return B;
}


//密码
+ (BOOL)validatePassword:(NSString *)passWord {
    NSString *passWordRegex        = @"^[a-zA-Z0-9]{6,15}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];

    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL)validateNickname:(NSString *)nickname {
    //@"^[\u4e00-\u9fa5]{4,20}$"
    NSString *nicknameRegex        = @"^[0-9a-z\\u4e00-\\u9fa5]{4,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];

    return [passWordPredicate evaluateWithObject:nickname];
}

//真实姓名
+ (BOOL)validateRealname:(NSString *)realName {
    //@"^[\u4e00-\u9fa5]{4,20}$"
    NSString *nicknameRegex        = @"^[\u4e00-\u9fa5]{2,5}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];

    return [passWordPredicate evaluateWithObject:realName];
}


//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2                   = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];

    return [identityCardPredicate evaluateWithObject:identityCard];
}


@end

//
//  Verification.h
//  JGB
//
//  Created by JGBMACMINI01 on 14-8-25.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XTVerification : NSObject
//邮箱
+ (BOOL)validateEmail:(NSString *)email;


//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo;


//车型
+ (BOOL)validateCarType:(NSString *)CarType;


//用户名
+ (BOOL)validateUserName:(NSString *)name;


//密码
+ (BOOL)validatePassword:(NSString *)passWord;


//昵称
+ (BOOL)validateNickname:(NSString *)nickname;


//真实姓名
+ (BOOL)validateRealname:(NSString *)realName;


//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard;


@end

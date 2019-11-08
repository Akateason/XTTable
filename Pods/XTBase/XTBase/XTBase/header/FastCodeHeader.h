//
//  FastCodeHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef FastCodeHeader_h
#define FastCodeHeader_h


#import <objc/runtime.h>

//-----------------------------------------------------------------------------//
//
// Images
//
#define QiNiuIMAGE_WITH_PHONE_WID(STR, W)   [STR stringByAppendingString:[NSString stringWithFormat:@"?imageView/2/w/%@", @(W)]]
// get scale 2x
#define GET_IMAGE_SIZE_SCALE2x(_size_)      CGSizeMake(_size_.width * 2., _size_.height * 2.)
#define XT_GET_IMAGE_SIZE_SCALE2x(_size_)   GET_IMAGE_SIZE_SCALE2x(_size_)

//-----------------------------------------------------------------------------//
//
// ASSOCIATED in category
//
// add id prop
#define ASSOCIATED(propertyName, setter, type, objc_AssociationPolicy)                           \
    -(type)propertyName {                                                                        \
        return objc_getAssociatedObject(self, _cmd);                                             \
    }                                                                                            \
                                                                                                 \
    -(void)setter : (type)object {                                                               \
        objc_setAssociatedObject(self, @selector(propertyName), object, objc_AssociationPolicy); \
    }

// add BOOL prop
#define ASSOCIATED_BOOL(propertyName, setter)                                                                  \
    -(BOOL)propertyName {                                                                                      \
        NSNumber *value = objc_getAssociatedObject(self, _cmd);                                                \
        return value.boolValue;                                                                                \
    }                                                                                                          \
                                                                                                               \
    -(void)setter : (BOOL)object {                                                                             \
        objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add NSInteger prop
#define ASSOCIATED_NSInteger(propertyName, setter)                                                             \
    -(NSInteger)propertyName {                                                                                 \
        NSNumber *value = objc_getAssociatedObject(self, _cmd);                                                \
        return value.integerValue;                                                                             \
    }                                                                                                          \
                                                                                                               \
    -(void)setter : (NSInteger)object {                                                                        \
        objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add float prop
#define ASSOCIATED_float(propertyName, setter)                                                                 \
    -(float)propertyName {                                                                                     \
        NSNumber *value = objc_getAssociatedObject(self, _cmd);                                                \
        return value.floatValue;                                                                               \
    }                                                                                                          \
                                                                                                               \
    -(void)setter : (float)object {                                                                            \
        objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add double prop
#define ASSOCIATED_double(propertyName, setter)                                                                \
    -(double)propertyName {                                                                                    \
        NSNumber *value = objc_getAssociatedObject(self, _cmd);                                                \
        return value.doubleValue;                                                                              \
    }                                                                                                          \
                                                                                                               \
    -(void)setter : (double)object {                                                                           \
        objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add long long prop
#define ASSOCIATED_longlong(propertyName, setter)                                                              \
    -(long long)propertyName {                                                                                 \
        NSNumber *value = objc_getAssociatedObject(self, _cmd);                                                \
        return value.longLongValue;                                                                            \
    }                                                                                                          \
                                                                                                               \
    -(void)setter : (long long)object {                                                                        \
        objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add CGPoint prop
#define ASSOCIATED_CGPOINT(propertyName, setter)                                                                                       \
    -(CGPoint)propertyName {                                                                                                           \
        NSValue *value = objc_getAssociatedObject(self, _cmd);                                                                         \
        return value.CGPointValue;                                                                                                     \
    }                                                                                                                                  \
                                                                                                                                       \
    -(void)setter : (CGPoint)object {                                                                                                  \
        objc_setAssociatedObject(self, @selector(propertyName), [NSValue valueWithCGPoint:object], OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

// add CGRect prop
#define ASSOCIATED_CGRECT(propertyName, setter)                                                                                       \
    -(CGRect)propertyName {                                                                                                           \
        NSValue *value = objc_getAssociatedObject(self, _cmd);                                                                        \
        return value.CGRectValue;                                                                                                     \
    }                                                                                                                                 \
                                                                                                                                      \
    -(void)setter : (CGRect)object {                                                                                                  \
        objc_setAssociatedObject(self, @selector(propertyName), [NSValue valueWithCGRect:object], OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }

//-----------------------------------------------------------------------------//
//
// User Default
//
#define USERDEFAULT_GET_VAL(key) \
    [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define XT_USERDEFAULT_GET_VAL(key)     USERDEFAULT_GET_VAL(key)


#define USERDEFAULT_SET_VAL(value, key)                                 \
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];

#define XT_USERDEFAULT_SET_VAL(value, key)     USERDEFAULT_SET_VAL(value, key)


#define USERDEFAULT_DELTE_VAL(key)                                  \
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];

#define XT_USERDEFAULT_DELTE_VAL(key)          USERDEFAULT_DELTE_VAL(key)
//-----------------------------------------------------------------------------//
//
// WEAK STRONG SELF
//
#define WEAK_SELF __weak typeof(self) weakSelf     = self;
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf;

#define XT_WEAKIFY(_a_)     __weak typeof(_a_) weakSelf     = _a_;
#define XT_STRONGIFY(_a_)   __strong typeof(weakSelf) _a_   = weakSelf;
//
//-----------------------------------------------------------------------------//
//
// STRING_FORMAT
//
#define STR_FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define XT_STR_FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
//
//-----------------------------------------------------------------------------//
//
// SINGLETON
//
// .h
//
#undef XT_SINGLETON_H
#define XT_SINGLETON_H(__class) \
    +(__class *)sharedInstance;

// .m
//
#undef XT_SINGLETON_M
#define XT_SINGLETON_M(__class)                                                 \
    static __class *__singleton__ = nil;                                        \
    +(__class *)sharedInstance {                                                \
        static dispatch_once_t once;                                            \
        dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; });     \
        return __singleton__;                                                   \
    }                                                                           \
    +(instancetype)allocWithZone : (struct _NSZone *)zone {                     \
        static dispatch_once_t once;                                            \
        dispatch_once(&once, ^{ __singleton__ = [super allocWithZone:zone]; }); \
        return __singleton__;                                                   \
    }                                                                           \
    -(instancetype)init {                                                       \
        static dispatch_once_t onceToken;                                       \
        dispatch_once(&onceToken, ^{                                            \
            __singleton__ = [super init];                                       \
        });                                                                     \
        return __singleton__;                                                   \
    }                                                                           \
    -(id)copyWithZone : (NSZone *)zone {                                        \
        return __singleton__;                                                   \
    }                                                                           \
    -(id)mutableCopyWithZone : (NSZone *)zone {                                 \
        return __singleton__;                                                   \
    }

//  + (id)copyWithZone:(struct _NSZone *)zone {                                 \
//      return  __singleton__;                                                  \
//  }                                                                           \
//  + (id)mutableCopyWithZone:(struct _NSZone *)zone {                          \
//      return __singleton__;                                                   \
//  }                                                                           \
//-----------------------------------------------------------------------------//
//
//  auto ENCODE DECODE
// encodeWithCoder
#define XT_encodeWithCoderRuntimeCls(A) \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[encoder encodeObject:value forKey:key];\
}\
free(ivars);\
} \
\
//
// initWithCoder
#define XT_initWithCoderRuntimeCls(A) \
\
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [decoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
} \
\
//
//-----------------------------------------------------------------------------//

#endif /* FastCodeHeader_h */

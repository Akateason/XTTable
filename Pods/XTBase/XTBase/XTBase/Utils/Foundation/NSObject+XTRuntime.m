//
//  NSObject+XTRuntime.m
//  XTlib
//
//  Created by teason23 on 2018/10/31.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "NSObject+XTRuntime.h"
#import <objc/runtime.h>

BOOL xt_method_swizzle(Class klass, SEL origSel, SEL altSel) {
    if (!klass)
        return NO;

    Method __block origMethod, __block altMethod;

    void (^find_methods)(void) = ^{
        unsigned methodCount = 0;
        Method *methodList   = class_copyMethodList(klass, &methodCount);

        origMethod = altMethod = NULL;

        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i) {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];

                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }

        free(methodList);
    };

    find_methods();

    if (!origMethod) {
        origMethod = class_getInstanceMethod(klass, origSel);

        if (!origMethod)
            return NO;

        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }

    if (!altMethod) {
        altMethod = class_getInstanceMethod(klass, altSel);

        if (!altMethod)
            return NO;

        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }

    find_methods();

    if (!origMethod || !altMethod)
        return NO;

    method_exchangeImplementations(origMethod, altMethod);

    return YES;
}

void xt_method_append(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || !selector)
        return;

    Method method = class_getInstanceMethod(fromClass, selector);

    if (!method)
        return;

    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void xt_method_replace(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || !selector)
        return;

    Method method = class_getInstanceMethod(fromClass, selector);

    if (!method)
        return;

    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}


@implementation NSObject (XTRuntime)

+ (void)xt_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod {
    xt_method_swizzle(self.class, originalMethod, newMethod);
}

+ (void)xt_appendMethod:(SEL)newMethod fromClass:(Class)klass {
    xt_method_append(self.class, klass, newMethod);
}

+ (void)xt_replaceMethod:(SEL)method fromClass:(Class)klass {
    xt_method_replace(self.class, klass, method);
}

- (BOOL)xt_respondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.class xt_instancesRespondToSelector:selector untilClass:stopClass];
}

- (BOOL)xt_superRespondsToSelector:(SEL)selector {
    return [self.superclass instancesRespondToSelector:selector];
}

- (BOOL)xt_superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.superclass xt_instancesRespondToSelector:selector untilClass:stopClass];
}

+ (BOOL)xt_instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass {
    BOOL __block (^__weak block_self)(Class klass, SEL selector, Class stopClass);
    BOOL (^block)(Class klass, SEL selector, Class stopClass) = [^(Class klass, SEL selector, Class stopClass) {
        if (!klass || klass == stopClass)
            return NO;

        unsigned methodCount = 0;
        Method *methodList   = class_copyMethodList(klass, &methodCount);

        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
                if (method_getName(methodList[i]) == selector)
                    return YES;

        return block_self(klass.superclass, selector, stopClass);
    } copy];

    block_self = block;

    return block(self.class, selector, stopClass);
}


@end

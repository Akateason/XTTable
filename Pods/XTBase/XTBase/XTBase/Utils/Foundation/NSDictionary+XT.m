//
//  NSDictionary+XT.m
//  XTlib
//
//  Created by teason23 on 2018/11/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "NSDictionary+XT.h"
#import "NSObject+XTRuntime.h"


@implementation NSDictionary (XT)

@end


@implementation NSDictionary (Safe)

+ (void)load {
#ifndef DEBUG
    [NSClassFromString(@"__NSPlaceholderDictionary") xt_swizzleMethod:@selector(initWithObjects:forKeys:count:)
                                                           withMethod:@selector(xt_initWithObjects:forKeys:count:)];
#endif
}

- (instancetype)xt_initWithObjects:(const id[])objects
                           forKeys:(const id<NSCopying>[])keys
                             count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j]    = key;
        safeObjects[j] = obj;
        j++;
    }

    return [self xt_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end


@implementation NSMutableDictionary (Safe)

+ (void)load {
#ifndef DEBUG
    [NSClassFromString(@"__NSDictionaryM") xt_swizzleMethod:@selector(setObject:forKey:)
                                                 withMethod:@selector(xt_setObject:forKey:)];
#endif
}

- (void)xt_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    [self xt_setObject:anObject forKey:aKey];
}

@end

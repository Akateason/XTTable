//
//  NSArray+XT.m
//  XTlib
//
//  Created by teason23 on 2018/11/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "NSArray+XT.h"
#import "NSObject+XTRuntime.h"


@implementation NSArray (XT)

@end


@implementation NSArray (Safe)

+ (void)load {
#ifndef DEBUG
    [NSClassFromString(@"__NSPlaceholderArray") xt_swizzleMethod:@selector(initWithObjects:count:)
                                                      withMethod:@selector(xt_initWithObjects:count:)];
    [NSClassFromString(@"__NSArrayI") xt_swizzleMethod:@selector(objectAtIndex:)
                                            withMethod:@selector(xt_objectAtIndex:)];
    [NSClassFromString(@"__NSArray0") xt_swizzleMethod:@selector(objectAtIndex:)
                                            withMethod:@selector(xt_zeroObjectAtIndex:)];
    [NSClassFromString(@"__NSSingleObjectArrayI") xt_swizzleMethod:@selector(objectAtIndex:)
                                                        withMethod:@selector(xt_singleObjectAtIndex:)];
#endif
}

- (instancetype)xt_initWithObjects:(id *)objects
                             count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }

    return [self xt_initWithObjects:objects count:newCnt];
}

- (id)xt_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    return [self xt_objectAtIndex:index];
}

- (id)xt_zeroObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self xt_zeroObjectAtIndex:index];
}

- (id)xt_singleObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self xt_singleObjectAtIndex:index];
}

@end


@implementation NSMutableArray (Safe)

+ (void)load {
#ifndef DEBUG
    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(objectAtIndex:)
                                            withMethod:@selector(xt_objectAtIndex:)];

    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(addObject:)
                                            withMethod:@selector(xt_addObject:)];

    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(removeObjectAtIndex:)
                                            withMethod:@selector(xt_removeObjectAtIndex:)];

    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(replaceObjectAtIndex:withObject:)
                                            withMethod:@selector(xt_replaceObjectAtIndex:withObject:)];

    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(removeObjectsInRange:)
                                            withMethod:@selector(xt_removeObjectsInRange:)];

    [NSClassFromString(@"__NSArrayM") xt_swizzleMethod:@selector(insertObject:atIndex:)
                                            withMethod:@selector(xt_insertObject:atIndex:)];
#endif
}

- (id)xt_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self xt_objectAtIndex:index];
}

- (void)xt_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self xt_addObject:anObject];
}

- (void)xt_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }

    return [self xt_removeObjectAtIndex:index];
}

- (void)xt_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }

    if (!anObject) {
        return;
    }

    [self xt_replaceObjectAtIndex:index withObject:anObject];
}

- (void)xt_removeObjectsInRange:(NSRange)range {
    if (range.location > self.count) {
        return;
    }

    if (range.length > self.count) {
        return;
    }

    if ((range.location + range.length) > self.count) {
        return;
    }

    return [self xt_removeObjectsInRange:range];
}

- (void)xt_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        return;
    }

    if (!anObject) {
        return;
    }

    [self xt_insertObject:anObject atIndex:index];
}

@end

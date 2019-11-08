//
//  XTThreadSafeObject.m
//  XTBase
//
//  Created by teason23 on 2018/11/26.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "XTThreadSafeObject.h"
#import "FastCodeHeader.h"

@implementation XTThreadSafeObject

- (id)init {
    self = [super init];
    if (self) {
        _mtsDispatchQueue = dispatch_queue_create("top.akateason.MultiThreadSafeObject", NULL);
    }
    return self;
}

- (void)dealloc {
    _mtsDispatchQueue = nil;
    _mtsContainer = nil;
}

#pragma mark - method over writing
- (NSString *)description {
    return _mtsContainer.description;
}

#pragma mark - public method
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [[_mtsContainer class] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSMethodSignature *sig = [anInvocation valueForKey:@"_signature"];
    
    const char *returnType = sig.methodReturnType;
//    NSLog(@"%@ = > %@",anInvocation.target, NSStringFromSelector(anInvocation.selector));
//    NSLog(@"%s",returnType);
    
    if (!strcmp(returnType, "v"))
    {
        //没有返回值 setter方法 异步barrier
        /** the setter method just use async dispatch
         remove the barrier to make it faster when u r sure that invacations will not affect each other
         */
        XT_WEAKIFY(self)
        dispatch_barrier_async(self->_mtsDispatchQueue, ^{
            XT_STRONGIFY(self)
            [anInvocation invokeWithTarget:self->_mtsContainer];
        });
    }
    else
    {
        //有返回值 getter方法 同步barrier
        /** all getter method need sync dispatch
         barrier make sure the result is correct
         getter method need barrier in most ways unless u dont except this */
        XT_WEAKIFY(self)
        dispatch_barrier_sync(self->_mtsDispatchQueue, ^{
            XT_STRONGIFY(self)
            [anInvocation invokeWithTarget:self->_mtsContainer];
        });
    }
}

@end

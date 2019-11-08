//
//  NSTimer+Addition.m
//  XTLoopScroll
//
//  Created by TuTu on 15/11/2.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "NSTimer+Addition.h"


@implementation NSTimer (Addition)

- (void)xt_pause {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)xt_resume {
    [self setFireDate:[NSDate date]];
}

//scheduled类方法创建计时器和进度上当前运行循环在默认模式（NSDefaultRunLoopMode）
+ (id)xt_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval
                                  block:(void (^)(void))inBlock
                                repeats:(BOOL)inRepeats {
    void (^block)(void) = [inBlock copy];
    id ret              = [self scheduledTimerWithTimeInterval:inTimeInterval
                                           target:self
                                         selector:@selector(xt_executeBlock:)
                                         userInfo:block
                                          repeats:inRepeats];
    return ret; // nstimer
}

//类方法创建计时器对象没有调度运行循环（RunLoop）在创建它，必须手动添加计时器运行循环，通过调用adddTimer:forMode:方法相应的NSRunLoop对象
+ (id)xt_timerWithTimeInterval:(NSTimeInterval)inTimeInterval
                         block:(void (^)(void))inBlock
                       repeats:(BOOL)inRepeats {
    void (^block)(void) = [inBlock copy];
    id ret              = [self timerWithTimeInterval:inTimeInterval
                                  target:self
                                selector:@selector(xt_executeBlock:)
                                userInfo:block
                                 repeats:inRepeats];
    return ret; // nstimer
}

+ (void)xt_executeBlock:(NSTimer *)inTimer {
    if ([inTimer userInfo]) {
        void (^block)(void) = (void (^)(void))[inTimer userInfo];
        block();
    }
}

@end

//
//  XTThreadSafeObject.h
//  XTBase
//
//  Created by teason23 on 2018/11/26.
//  Copyright © 2018 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTThreadSafeObject : NSObject
{
    dispatch_queue_t _mtsDispatchQueue;
    NSObject *_mtsContainer;
}
@property (nonatomic, strong) NSObject *mtsContainer;
@end

NS_ASSUME_NONNULL_END

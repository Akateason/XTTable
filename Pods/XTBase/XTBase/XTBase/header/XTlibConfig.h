//
//  XTlibConfig.h
//  XTlib
//
//  Created by teason23 on 2018/10/18.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastCodeHeader.h"

NS_ASSUME_NONNULL_BEGIN


@interface XTlibConfig : NSObject
XT_SINGLETON_H(XTlibConfig);

@property (nonatomic) BOOL isDebug;

@end

NS_ASSUME_NONNULL_END

//
//  XTMutableArray.m
//  XTBase
//
//  Created by teason23 on 2018/11/26.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "XTMutableArray.h"

@implementation XTMutableArray
- (id)init {
    self = [super init];
    if (self) {
        self.mtsContainer = [NSMutableArray array];
    }
    return self;
}
@end

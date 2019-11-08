//
//  UIResponder+ChainHandler.m
//  XTkit
//
//  Created by teason23 on 2017/10/23.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIResponder+ChainHandler.h"


@implementation UIResponder (ChainHandler)

- (void)sendChainHandler:(NSString *)identifier info:(id)info {
    if ([self receiveHandleChain:identifier info:info sender:nil] && self.nextResponder) [self.nextResponder sendChainHandler:identifier info:info sender:nil];
}

- (void)sendChainHandler:(NSString *)identifier info:(id)info sender:(id)sender {
    if ([self receiveHandleChain:identifier info:info sender:sender] && self.nextResponder) [self.nextResponder sendChainHandler:identifier info:info sender:sender];
}

- (BOOL)receiveHandleChain:(NSString *)identifier info:(id)info sender:(id)sender {
    return YES;
}

@end

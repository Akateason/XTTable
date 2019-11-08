//
//  UIResponder+ChainHandler.h
//  XTkit
//
//  Created by teason23 on 2017/10/23.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIResponder (ChainHandler)

- (void)sendChainHandler:(NSString *)identifier info:(id)info;
- (void)sendChainHandler:(NSString *)identifier info:(id)info sender:(id)sender;

- (BOOL)receiveHandleChain:(NSString *)identifier info:(id)info sender:(id)sender;

@end

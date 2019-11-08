//
//  XTJson.h
//  subao
//
//  Created by TuTu on 16/1/7.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XTJson : NSObject

+ (id)getJsonWithStr:(NSString *)jsonStr;
+ (NSString *)getStrWithJson:(id)jsonObj;

@end

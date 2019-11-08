//
//  UIImageView+QNExtention.m
//  pro
//
//  Created by TuTu on 16/9/12.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "UIImageView+QNExtention.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView (QNExtention)

- (void)photoFromQiNiu:(NSString *)imgUrl {
    //    NSString *formatString = [NSString stringWithFormat:@"?imageView/2/w/%d/h/%d",(int)APP_WIDTH,(int)APP_HEIGHT] ;
    //    imgUrl = [imgUrl stringByAppendingString:formatString] ;
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}


@end

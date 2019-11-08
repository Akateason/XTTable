//
//  ALAssetsLibrary+CustomPhotoAlbum.h
//  subao
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SaveImageCompletion)(NSError *error);


@interface ALAssetsLibrary (CustomPhotoAlbum)

- (void)saveImage:(UIImage *)image
          toAlbum:(NSString *)albumName
  completionBlock:(SaveImageCompletion)completionBlock;

- (void)addAssetURL:(NSURL *)assetURL
            toAlbum:(NSString *)albumName
    completionBlock:(SaveImageCompletion)completionBlock;

@end

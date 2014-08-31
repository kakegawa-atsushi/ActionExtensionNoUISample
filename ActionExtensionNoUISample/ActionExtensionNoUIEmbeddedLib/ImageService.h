//
//  ImageService.h
//  ActionExtensionNoUISample
//
//  Created by KAKEGAWA Atsushi on 2014/08/31.
//  Copyright (c) 2014年 KAKEGAWA Atsushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageService : NSObject

- (BOOL)saveLatestImage:(UIImage *)image error:(NSError * __autoreleasing *)error;
- (UIImage *)loadLatestImage;

@end

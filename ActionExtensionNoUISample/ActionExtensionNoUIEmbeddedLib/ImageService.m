//
//  ImageService.m
//  ActionExtensionNoUISample
//
//  Created by KAKEGAWA Atsushi on 2014/08/31.
//  Copyright (c) 2014年 KAKEGAWA Atsushi. All rights reserved.
//

#import "ImageService.h"
#import "ActionExtensionNoUIConstants.h"

static NSString * const UserDefaultsLastestImagePathKey = @"latestImagePath";

@implementation ImageService

- (BOOL)saveLatestImage:(UIImage *)image error:(NSError *__autoreleasing *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *destURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:AppGroupIdentifier];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate new]];
    
    NSString *filePath = [dateString stringByAppendingPathExtension:@"png"];
    destURL = [destURL URLByAppendingPathComponent:filePath];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    BOOL succeeded = [data writeToURL:destURL atomically:YES];
    if (!succeeded) {
        *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                     code:NSFileWriteUnknownError
                                 userInfo:nil];
        return NO;
    }
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupIdentifier];
    [defaults setObject:filePath forKey:UserDefaultsLastestImagePathKey];
    [defaults synchronize];
    
    return YES;
}

- (UIImage *)loadLatestImage {
    UIImage *image = nil;
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupIdentifier];
    NSString *relativePath = [defaults objectForKey:UserDefaultsLastestImagePathKey];
    
    if (relativePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *containerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:AppGroupIdentifier];
        NSString *filePath = [containerURL.path stringByAppendingPathComponent:relativePath];
        
        image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    return image;
}

@end

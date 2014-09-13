//
//  ActionRequestHandler.m
//  SaveImageExtension
//
//  Created by KAKEGAWA Atsushi on 2014/08/31.
//  Copyright (c) 2014年 KAKEGAWA Atsushi. All rights reserved.
//

#import "ActionRequestHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>

@import ActionExtensionNoUIEmbeddedLib;

@interface ActionRequestHandler ()

@property (nonatomic, strong) NSExtensionContext *extensionContext;

@end

@implementation ActionRequestHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    self.extensionContext = context;
    
    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider = item.attachments.firstObject;
    
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
        
        __weak typeof(self) weakSelf = self;
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(id<NSSecureCoding> item, NSError *error) {
            if (error) {
                [weakSelf.extensionContext cancelRequestWithError:error];
                return;
            }
            
            if (![(NSObject *)item isKindOfClass:[UIImage class]]) {
                NSError *unavailableError = [NSError errorWithDomain:NSItemProviderErrorDomain
                                                                code:NSItemProviderUnexpectedValueClassError
                                                            userInfo:nil];
                [weakSelf.extensionContext cancelRequestWithError:unavailableError];
                return;
            }
            
            UIImage *image = (UIImage *)item;
            
            NSError *serviceError = nil;
            ImageService *service = [ImageService new];
            [service saveLatestImage:image error:&serviceError];
            
            if (serviceError) {
                [weakSelf.extensionContext cancelRequestWithError:serviceError];
                return;
            }
            
            [weakSelf.extensionContext completeRequestReturningItems:nil completionHandler:nil];
        }];
    } else {
        NSError *unavailableError = [NSError errorWithDomain:NSItemProviderErrorDomain
                                                        code:NSItemProviderItemUnavailableError
                                                    userInfo:nil];
        [self.extensionContext cancelRequestWithError:unavailableError];
    }
}

@end

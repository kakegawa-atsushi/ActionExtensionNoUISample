//
//  ViewController.m
//  ActionExtensionNoUIHostSample
//
//  Created by KAKEGAWA Atsushi on 2014/08/31.
//  Copyright (c) 2014年 KAKEGAWA Atsushi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
            
- (IBAction)cameraButtonDidTouch:(id)sender {
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)actionButtonDidTouch:(id)sender {
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image]
                                                                                 applicationActivities:nil];
    [viewController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        NSString *message;
        
        if (activityError) {
            message = activityError.localizedDescription;
        } else {
            message = @"イメージを保存しました";
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        [alertController addAction:action];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

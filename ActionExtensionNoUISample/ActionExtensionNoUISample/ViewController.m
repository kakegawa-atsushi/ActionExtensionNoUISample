//
//  ViewController.m
//  ActionExtensionNoUISample
//
//  Created by KAKEGAWA Atsushi on 2014/08/31.
//  Copyright (c) 2014年 KAKEGAWA Atsushi. All rights reserved.
//

#import "ViewController.h"

@import ActionExtensionNoUIEmbeddedLib;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageService *service = [ImageService new];
    self.imageView.image = [service loadLatestImage];
}

@end

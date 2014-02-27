//
//  FirstViewController.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "SingleFileController.h"

@interface SingleFileController ()

@end

@implementation SingleFileController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rogue-logo1.jpg"]];
    logo.frame = CGRectMake(15, 40, 150, 50);
    [self.view addSubview:logo];
}

@end

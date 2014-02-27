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

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rogue-Logo.png"]];
    logo.frame = CGRectMake(15, 40, 150, 55);
    [self.view addSubview:logo];

    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 300, 50)];
    welcomeLabel.text = @"Welcome to the Rogue Brewary app. Drink beer, be merry";
    welcomeLabel.numberOfLines = 2;
    [self.view addSubview:welcomeLabel];
}

@end

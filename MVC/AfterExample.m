//
//  AfterExample.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "AfterExample.h"

@interface AfterExample ()

@end


@implementation AfterExample

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(85, 150, 200, 50)];
    info.text = @"Put your code here";
    [self.view addSubview:info];
}

@end

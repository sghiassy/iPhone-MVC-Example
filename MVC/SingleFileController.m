//
//  FirstViewController.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "SingleFileController.h"

@interface SingleFileController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SingleFileController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rogue-Logo.png"]];
    logo.frame = CGRectMake(15, 40, 150, 55);
    [self.view addSubview:logo];

    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 300, 50)];
    welcomeLabel.text = @"Welcome to the Rogue Brewary app. Drink beer, be merry";
    welcomeLabel.numberOfLines = 2;
    [self.view addSubview:welcomeLabel];

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(15, 170, 285, 230) style:UITableViewStylePlain];
    table.layer.borderColor = [UIColor blueColor].CGColor;
    table.layer.borderWidth = 1.0;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

#pragma mark - UITableViewDataSource Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title"];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Title"];
        cell.textLabel.text = @"Shaheen";
    }

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

@end

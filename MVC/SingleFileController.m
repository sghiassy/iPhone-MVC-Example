//
//  FirstViewController.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "SingleFileController.h"
#import "AFHTTPRequestOperationManager.h"



@interface SingleFileController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *beers;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) id JSON;

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

    self.table = [[UITableView alloc] initWithFrame:CGRectMake(15, 170, 285, 240) style:UITableViewStylePlain];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];

    [self fetchDeals];
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

#pragma mark - UITableViewDataSource Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beers.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title"];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Title"];
    }

    if (self.beers != nil) {
        UILabel *beerName = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
        beerName.text = [self.beers[1] objectForKey:@"name"];
        [cell.contentView addSubview:beerName];

        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(200, 70, 100, 50)];
        price.text = [self.beers[indexPath.row] objectForKey:@"discountPrice"];
        price.font = [UIFont systemFontOfSize:28];
        price.textColor = [UIColor colorWithRed:(22.0/255.0) green:(111.0/255.0) blue:(66.0/255.0) alpha:1];
        [cell.contentView addSubview:price];

        UIImageView *pic = [[UIImageView alloc] init];
        pic.frame = CGRectMake(10, 10, 32, 100);
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://localhost:9000", [self.beers[indexPath.row] objectForKey:@"image"]]]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        [pic setImage:image];
        [cell.contentView addSubview:pic];
    }

    return cell;
}

#pragma API Calls

- (void)fetchDeals {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.localhost:9000/beers" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.JSON = responseObject;
        [self handleResponse];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)handleResponse {
    self.beers = self.JSON;
    [self.table reloadData];
}

@end

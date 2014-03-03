//
//  Controller.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "Controller.h"
#import "AFHTTPRequestOperationManager.h"

// Imported during MVC Seperation
#import "HeaderView.h"
#import "BeerList.h"

static NSString *kHostAPI = @"http://api.shaheenghiassy.com";
static NSString *kHost = @"http://shaheenghiassy.com";


@interface Controller ()

//@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) BeerList *beerList;


@end


@implementation Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    HeaderView *header = [[HeaderView alloc] init];
    [self.view addSubview:header];

    self.beerList = [[BeerList alloc] initWithDelegate:self andFrame:CGRectMake(15, 170, 285, 240)];
    [self.view addSubview:self.beerList.tableView];

    [self fetchDeals];
}



#pragma API Calls

- (void)fetchDeals {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        self.beerJSON = responseObject;
        self.beerList.beerJSON = responseObject;
//        [self.table reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers/price"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        self.priceJSON = responseObject;
//        [self.table reloadData];
        self.beerList.priceJSON = responseObject;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end

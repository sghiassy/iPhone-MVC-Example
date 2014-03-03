//
//  Controller.m
//  MVC
//
//  Created by Shaheen Ghiassy on 2/27/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "Controller.h"

// Imported during MVC Seperation
#import "HeaderView.h"
#import "BeerList.h"
#import "DataSource.h"



@interface Controller ()

@property (strong, nonatomic) BeerList *beerList;

@end


@implementation Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    HeaderView *header = [[HeaderView alloc] init];
    [self.view addSubview:header];

    self.beerList = [[BeerList alloc] initWithDelegate:self andFrame:CGRectMake(15, 170, 285, 240)];
    [self.view addSubview:self.beerList.tableView];

    DataSource *dataSource = [[DataSource alloc] initWithDelegate:self];
    [dataSource fetchDeals];
}



#pragma API Calls

- (void)beersReceieved:(id)beers {
    self.beerList.beerJSON = beers;
}
- (void)pricesReceived:(id)price {
    self.beerList.priceJSON = price;
}


@end

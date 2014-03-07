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

#define CGMakeBeerTable CGRectMake(15, 170, 285, 240)

@interface Controller ()

@property (strong, nonatomic) BeerList *beerList;

@end


@implementation Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    HeaderView *header = [[HeaderView alloc] init];
    [self.view addSubview:header];

    self.beerList = [[BeerList alloc] initWithDelegate:self andFrame:CGMakeBeerTable];
    [self.view addSubview:self.beerList.tableView];

    DataSource *dataSource = [[DataSource alloc] initWithDelegate:self];
    [dataSource fetchBeers];
}

- (void)beersReceieved:(NSArray *)beers {
    [self.beerList addBeers:beers];
}

@end

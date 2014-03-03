//
//  DataSource.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "DataSource.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *kHostAPI = @"http://api.shaheenghiassy.com";
static NSString *kHost = @"http://shaheenghiassy.com";


@interface DataSource ()

@property (weak, nonatomic) Controller *ctlr;

@end


@implementation DataSource

- (id)initWithDelegate:(Controller *)delegate {
    self = [super init];

    if (self) {
        _ctlr = delegate;
    }

    return self;
}

- (void)fetchDeals {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.ctlr beersReceieved:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers/price"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.ctlr pricesReceived:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end

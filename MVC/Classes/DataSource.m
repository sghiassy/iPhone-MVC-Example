//
//  DataSource.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "DataSource.h"
#import "AFHTTPRequestOperationManager.h"
#import "DataSourceStateMachine.h"
#import "Model.h"

static NSString *kHostAPI = @"http://api.shaheenghiassy.com";
static NSString *kHost = @"http://shaheenghiassy.com";


@interface DataSource ()

@property (weak, nonatomic) Controller *ctlr;
@property (strong, nonatomic) DataSourceStateMachine *stateMachine;

@property (strong, nonatomic) id beerJSON;
@property (strong, nonatomic) id priceJSON;

@end


@implementation DataSource

- (id)initWithDelegate:(Controller *)delegate {
    self = [super init];

    if (self) {
        _ctlr = delegate;
        _stateMachine = [[DataSourceStateMachine alloc] initWithDelegate:self];
    }

    return self;
}

- (void)fetchDeals {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        self.beerJSON = responseObject;
        [self.stateMachine sendMessage:@"receivedProductInfo"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    [manager GET:[NSString stringWithFormat:@"%@%@", kHostAPI, @"/beers/price"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        self.priceJSON = responseObject;
        [self.stateMachine sendMessage:@"receivedPrices"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

/**
 *  Convert JSON into proper Models.
 *  This method can only be called after both API calls have been
 *  recieved. We use a state chart to manage state.
 */
- (void)allJSONReceived {
    NSMutableArray *beers = [[NSMutableArray alloc] init];

    NSUInteger numberOfBeers = [self.beerJSON count];

    for (NSUInteger i = 0; i < numberOfBeers; i++) {
        Model *model = [[Model alloc] init];
        [model setPriceInfo:self.priceJSON[i]];
        [model setProductInfo:self.beerJSON[i]];
        [model setHost:kHost];
        [beers addObject:model];
    }

    [self.ctlr beersReceieved:beers];
}

@end

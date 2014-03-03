//
//  BeerList.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "BeerList.h"
#import "Controller.h"

static NSString *kHostAPI = @"http://api.shaheenghiassy.com";
static NSString *kHost = @"http://shaheenghiassy.com";


@interface BeerList ()

@property (weak, nonatomic) Controller *ctlr;

@end



@implementation BeerList

- (void)setPriceJSON:(id)priceJSON {
    _priceJSON = priceJSON;
    [self.tableView reloadData];
}

- (void)setBeerJSON:(id)beerJSON {
    _beerJSON = beerJSON;
    [self.tableView reloadData];
}

#pragma mark - Object Lifecycle

- (id)initWithDelegate:(id)delegate andFrame:(CGRect)frame {
    self = [super init];

    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.ctlr = delegate;
        self.tableView.frame = frame;
    }

    return self;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
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
    }

    if (self.beerJSON != nil && self.priceJSON != nil) {
        UILabel *beerName = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
        beerName.text = [self.beerJSON[indexPath.row] objectForKey:@"name"];
        [cell.contentView addSubview:beerName];

        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(200, 70, 100, 50)];

        if ([[self.priceJSON[indexPath.row] objectForKey:@"discountPriceActive"] integerValue] == 0) {
            price.text = [self.priceJSON[indexPath.row] objectForKey:@"consumerPrice"];
        } else {
            price.text = [self.priceJSON[indexPath.row] objectForKey:@"discountPrice"];
        }
        price.font = [UIFont systemFontOfSize:28];
        price.textColor = [UIColor colorWithRed:(22.0/255.0) green:(111.0/255.0) blue:(66.0/255.0) alpha:1];
        [cell.contentView addSubview:price];

        UIImageView *pic = [[UIImageView alloc] init];
        pic.frame = CGRectMake(10, 10, 32, 100);

        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kHost, [self.beerJSON[indexPath.row] objectForKey:@"image"]]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];

        [pic setImage:image];
        [cell.contentView addSubview:pic];
    }
    
    return cell;
}

@end

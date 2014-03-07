//
//  BeerList.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "BeerList.h"
#import "Controller.h"
#import "Model.h"

@interface BeerList ()

@property (weak, nonatomic) Controller *ctlr;
@property (strong, nonatomic) NSArray *beers;

@end



@implementation BeerList

- (void)addBeers:(NSArray *)beers {
    self.beers = beers;
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
    return [self.beers count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title"];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Title"];

        NSUInteger row = indexPath.row;
        Model *beer = [self.beers objectAtIndex:row];

        UILabel *beerName = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
        beerName.text = [beer getName];
        [cell.contentView addSubview:beerName];

        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(200, 70, 100, 50)];
        price.text = [NSString stringWithFormat:@"$%@", [beer getPrice]];
        price.font = [UIFont systemFontOfSize:28];
        price.textColor = [UIColor colorWithRed:(22.0/255.0) green:(111.0/255.0) blue:(66.0/255.0) alpha:1];
        [cell.contentView addSubview:price];

        UIImageView *pic = [[UIImageView alloc] init];
        pic.frame = CGRectMake(10, 10, 32, 100);

        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[beer getImageUrl]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        
        [pic setImage:image];
        [cell.contentView addSubview:pic];
    }

    return cell;
}

@end

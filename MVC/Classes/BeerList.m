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
#import "BeerCard.h"

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
    return [BeerCard height];
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
        BeerCard *card = [[BeerCard alloc] initWithFrame:CGRectMake(0, 0, 320, 44) andModel:self.beers[indexPath.row]];
        [cell.contentView addSubview:card];
    }

    return cell;
}

@end

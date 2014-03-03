//
//  BeerList.h
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerList : UITableViewController

- (id)initWithDelegate:(id)delegate andFrame:(CGRect)frame;

@property (strong, nonatomic) id beerJSON;
@property (strong, nonatomic) id priceJSON;

@end

//
//  BeerCard.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "BeerCard.h"

@implementation BeerCard

- (id)initWithFrame:(CGRect)frame andModel:(Model *)model {
    frame.size.height = [BeerCard height];
    self = [super initWithFrame:frame];

    if (self) {
        UILabel *beerName = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
        beerName.text = [model getName];
        [self addSubview:beerName];

        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(200, 70, 100, 50)];
        price.text = [NSString stringWithFormat:@"$%@", [model getPrice]];
        price.font = [UIFont systemFontOfSize:28];
        price.textColor = [UIColor colorWithRed:(22.0/255.0) green:(111.0/255.0) blue:(66.0/255.0) alpha:1];
        [self addSubview:price];

        UIImageView *pic = [[UIImageView alloc] init];
        pic.frame = CGRectMake(10, 10, 32, 100);

        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[model getImageUrl]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];

        [pic setImage:image];
        [self addSubview:pic];
    }

    return self;
}

+ (NSUInteger)height {
    return 120;
}

@end

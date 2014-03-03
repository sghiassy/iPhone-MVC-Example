//
//  HeaderView.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rogue-Logo.png"]];
        logo.frame = CGRectMake(15, 40, 150, 55);
        [self addSubview:logo];

        UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 300, 50)];
        welcomeLabel.text = @"Welcome to the Rogue Brewary app. Drink beer, be merry";
        welcomeLabel.numberOfLines = 2;
        [self addSubview:welcomeLabel];
    }

    return self;
}

@end

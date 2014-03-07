//
//  BeerCard.h
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface BeerCard : UIView

+ (NSUInteger)height;
- (id)initWithFrame:(CGRect)frame andModel:(Model *)model;

@end

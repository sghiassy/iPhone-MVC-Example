//
//  DataSource.h
//  MVC
//
//  Created by Shaheen Ghiassy on 3/3/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Controller.h"

@interface DataSource : NSObject

- (id)initWithDelegate:(Controller *)delegate;
- (void)fetchDeals;

@end

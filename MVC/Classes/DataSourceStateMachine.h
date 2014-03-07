//
//  DataSourceStateMachine.h
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface DataSourceStateMachine : NSObject

- (id)initWithDelegate:(DataSource *)delegate;
- (void)sendMessage:(NSString *)message;
- (NSString *)getCurrentState;

@end

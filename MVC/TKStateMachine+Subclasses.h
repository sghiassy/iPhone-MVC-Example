//
//  TKStateMachine+Subclass.h
//  GreenMachine
//
//  Created by Daniel Beard on 2/4/14.
//  Copyright (c) 2014 Groupon Inc. All rights reserved.
//

#import "TKStateMachine.h"

@interface TKStateMachine ()

@property (nonatomic, strong) NSMutableSet *mutableStates;
@property (nonatomic, strong) NSMutableSet *mutableEvents;

@end

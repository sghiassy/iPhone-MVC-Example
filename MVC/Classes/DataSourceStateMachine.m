//
//  DataSourceStateMachine.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "DataSourceStateMachine.h"
#import "GPStateMachine.h"

@interface DataSourceStateMachine ()

@property (weak, nonatomic) DataSource *delegate;
@property (strong, nonatomic) GPStateMachine *stateMachine;

@end

@implementation DataSourceStateMachine

- (id)initWithDelegate:(DataSource *)delegate {
    self = [super init];

    if (self) {
        _delegate = delegate;

        NSMutableDictionary *stateMachineDictionary = [@{
                                                         tkInitialState:@"Init",
                                                         tkStates:@{
                                                                 @"Init":@{
                                                                         tkExitTransitions:@[@"ReceivedPrices", @"receivedPrices",
                                                                                             @"ReceivedProductInfo", @"receivedProductInfo"]
                                                                         },
                                                                 @"ReceivedPrices":@{
                                                                         tkExitTransitions:@[@"Ready", @"receivedProductInfo"]
                                                                         },
                                                                 @"ReceivedProductInfo":@{
                                                                         tkExitTransitions:@[@"Ready", @"receivedPrices"]
                                                                         },
                                                                 @"Ready":@{
                                                                         
                                                                         }
                                                                 }
                                                         } mutableCopy];
        
        _stateMachine = [[GPStateMachine alloc] initWithDictionary:stateMachineDictionary];
        [_stateMachine setTranslatesEnterExitEventsToSelectorsForTarget:self];
        [_stateMachine activate];
    }
    return self;
}

- (void)stateMachine:(TKStateMachine *)stateMachine didEnterReadyState:(TKState *)state transition:(TKTransition *)transition {
    [self.delegate allJSONReceived];
}

- (NSString *)getCurrentState {
    return self.stateMachine.currentState.name;
}

- (void)sendMessage:(NSString *)message {
    [self.stateMachine fireEvent:message userInfo:nil error:nil];
}

@end

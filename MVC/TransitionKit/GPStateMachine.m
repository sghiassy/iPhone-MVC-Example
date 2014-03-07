//
//  GPStateMachine.m
//  GreenMachine
//
//  Created by Daniel Beard on 1/31/14.
//  Copyright (c) 2014 Groupon Inc. All rights reserved.
//

#import "GPStateMachine.h"
#import "TKStateMachine+Subclasses.h"
#import "NSDictionary+fetchPropertyValues.h"
#import "TKState.h"
#import "TKEvent.h"
#import "TKTransition.h"
#import <objc/message.h>

NSString *const tkInitialState    = @"tkInitialState";
NSString *const tkStates          = @"tkStates";
NSString *const tkEnterBlock      = @"tkEnterBlock";
NSString *const tkExitBlock       = @"tkExitBlock";
NSString *const tkExitTransitions = @"tkExitTransitions";

#define TKRaiseIfActive() \
    if ([self isActive]) [NSException raise:TKStateMachineIsImmutableException format:@"Unable to modify state machine: The state machine has already been activated."];

@interface GPStateMachine ()

@property (nonatomic, weak) id target;

@end

@implementation GPStateMachine

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        // Not passed a dictionary
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            [NSException raise:NSInvalidArgumentException format:@"State machine initialized with not dictionary"];
        }

        // Define mutableDictionary, this will hold our initialised TKStates, keyed by name
        NSMutableDictionary *definedStates = [NSMutableDictionary dictionary];

        // Get all states defined in dictionary
        NSDictionary *stateDictionary = [dictionary dictionaryForKey:tkStates];
        // No states
        if (!stateDictionary) {
            [NSException raise:NSInvalidArgumentException format:@"No states defined in dictionary"];
        }

        // First pass, define all the states
        // Loop through state dictionary, and define the proper states
        for (NSString *stateName in [stateDictionary allKeys]) {
            // Get the current state dictionary
            NSDictionary *currentStateDictionary = stateDictionary[stateName];
            // Value for state name is not a dictionary
            if (![currentStateDictionary isKindOfClass:[NSDictionary class]]) {
                [NSException raise:NSInvalidArgumentException format:@"State (%@) is not a dictionary", stateName];
            }

            // Create state and add to stateDictionary
            TKState *state = [TKState stateWithName:stateName];
            definedStates[stateName] = state;

            // If we have an enterBlock, add it to the state
            if (currentStateDictionary[tkEnterBlock]) {
                [state setDidEnterStateBlock:currentStateDictionary[tkEnterBlock]];
            }

            // If we have an exitBlock, add it to the state
            if (currentStateDictionary[tkExitBlock]) {
                [state setDidExitStateBlock:currentStateDictionary[tkExitBlock]];
            }
        }

        // Add states to state machine
        [self addStates:[definedStates allValues]];

        // Set initial state
        NSString *initialStateName = dictionary[tkInitialState];
        // No initial state set
        if (!initialStateName.length) {
            [NSException raise:NSInvalidArgumentException format:@"Initial state is not set"];
        }
        TKState *initialState = [self stateNamed:initialStateName];
        if (initialState == nil) {
            [NSException raise:NSInvalidArgumentException format:@"No state matching state found for the initial state name"];
        }
        self.initialState = initialState;

        // Second pass, we now have all the states defined, so now we can define the events and transitions
        NSMutableArray *events = [NSMutableArray array];
        for (NSString *stateName in [stateDictionary allKeys]) {
            // Get the current stateDictionary
            NSDictionary *currentStateDictionary = stateDictionary[stateName];

            // If this state doesn't have an exit transition, then skip it, it's a 'leaf' state
            if ([currentStateDictionary[tkExitTransitions] isKindOfClass:[NSArray class]] == NO) {
                continue;
            }

            // Get state from our mutable states dictionary
            TKState *state = definedStates[stateName];

            // Loop through exit transitions for this state
            NSArray *exitTransitions = currentStateDictionary[tkExitTransitions];
            // Uneven number of transitions
            if (exitTransitions.count % 2 != 0) {
                [NSException raise:NSInvalidArgumentException format:@"Exit transition for state (%@) defined with uneven number of keys/values", state.name];
            }
            for (NSInteger i = 0; i <= exitTransitions.count - 2; i += 2) {
                NSString *transitioningToStateName = exitTransitions[i];
                NSString *transitionEventName      = exitTransitions[i + 1];

                // Verify that the state we are transitioning to is a valid state
                TKState *transitioningToState = [self stateNamed:transitioningToStateName];
                if (!transitioningToState) {
                    [NSException raise:NSInvalidArgumentException format:@"No state named (%@) exists for exit transition with event (%@)", transitioningToStateName, transitionEventName];
                }
                if (![transitionEventName isKindOfClass:[NSString class]] || !transitionEventName.length) {
                    [NSException raise:NSInvalidArgumentException format:@"Transition value for state (%@) is invalid", state.name];
                }

                // Create event
                TKEvent *event = [TKEvent eventWithName:transitionEventName transitioningFromStates:@[ state ] toState:transitioningToState];
                [events addObject:event];
            }
        }

        // Add events to state machine
        [self addEvents:events];
    }
    return self;
}

#pragma mark - DidEnterExit Util Methods

- (void)setTranslatesEnterExitEventsToSelectorsForTarget:(id)target {
    TKRaiseIfActive();
    self.target = target;
}

- (void)generateCallBackForDidEnterState:(TKState *)state transition:(TKTransition *)transition {
    NSString *selectorString = [NSString stringWithFormat:@"stateMachine:didEnter%@State:transition:", [state.name capitalizedString]];
    SEL      selector        = NSSelectorFromString(selectorString);

    if (self.target && [self.target respondsToSelector:selector]) {
        objc_msgSend(self.target, selector, self, state, transition);
    }
}

- (void)generateCallBackForDidExitState:(TKState *)state transition:(TKTransition *)transition {
    NSString *selectorString = [NSString stringWithFormat:@"stateMachine:didExit%@State:transition:", [state.name capitalizedString]];
    SEL      selector        = NSSelectorFromString(selectorString);

    if (self.target && [self.target respondsToSelector:selector]) {
        objc_msgSend(self.target, selector, self, state, transition);
    }
}

#pragma mark - Overridden methods

- (void)activate {
    [super activate];

    // Auto selector generator
    [self generateCallBackForDidEnterState:self.initialState transition:nil];
}

- (BOOL)fireEvent:(id)eventOrEventName userInfo:(NSDictionary *)userInfo error:(NSError *__autoreleasing *)error {
    // Start listening for the TKStateMachineDidChangeStateNotification,
    // this is so we can add our callbacks without having to modify TKStateMachine internals
    __block __weak id eventObserver = [[NSNotificationCenter defaultCenter] addObserverForName:TKStateMachineDidChangeStateNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        // Get the states and event from the userInfo
        TKState *oldState = (TKState *)note.userInfo[TKStateMachineDidChangeStateOldStateUserInfoKey];
        TKState *newState = (TKState *)note.userInfo[TKStateMachineDidChangeStateNewStateUserInfoKey];
        TKEvent *event = (TKEvent *)note.userInfo[TKStateMachineDidChangeStateEventUserInfoKey];
        TKTransition *transition = [TKTransition transitionForEvent:event fromState:oldState inStateMachine:self userInfo:userInfo];

        // Generate did exit state callback
        [self generateCallBackForDidExitState:oldState transition:transition];

        // Generate did enter state callback
        [self generateCallBackForDidEnterState:newState transition:transition];

        // Remove the observer
        [[NSNotificationCenter defaultCenter] removeObserver:eventObserver name:TKStateMachineDidChangeStateNotification object:nil];
        eventObserver = nil;
    }];

    // Get the list of events matching the eventName
    // We support multiple events with the same name, so we need either a TKEvent object, or
    // have to sort by matching name && allowed source states (matching current state)
    TKEvent *event = nil;

    if ([eventOrEventName isKindOfClass:[NSString class]]) {
        for (TKEvent *eventNamed in [self eventsNamed:eventOrEventName]) {
            if ([self canFireEvent:eventNamed]) {
                event = eventNamed;
                break;
            }
        }
    } else {
        event = eventOrEventName;
    }

    // Fire the event on super or generate proper error.
    BOOL result = NO;
    if (event) {
        // Call super
        result = [super fireEvent:event userInfo:userInfo error:error];
    } else {
        result = NO;
        // Construct error of why result == NO
        NSString     *failureReason = [NSString stringWithFormat:@"An attempt to fire the '%@' event was declined because `shouldFireEventBlock` returned `NO`.", event.name];
        NSDictionary *userInfo      = @{ NSLocalizedDescriptionKey:@"The event declined to be fired.", NSLocalizedFailureReasonErrorKey:failureReason };
        if (error) {
            *error = [NSError errorWithDomain:TKErrorDomain code:TKTransitionDeclinedError userInfo:userInfo];
        }
    }

    // If the notification was not fired, remove the observer
    if (!result) {
        [[NSNotificationCenter defaultCenter] removeObserver:eventObserver name:TKStateMachineDidChangeStateNotification object:nil];
        eventObserver = nil;
    }

    return result;
}

#pragma mark - Private Methods

/**
   This is a private method.
   Returns an array of events where their name matches the input string
   @param eventName, an NSString that we compare to valid event.name properties
   @return NSArray of TKEvent objects that have a name matching the input parameter
 */
- (NSArray *)eventsNamed:(NSString *)eventName {
    NSMutableArray *events = [NSMutableArray array];

    for (TKEvent *event in self.mutableEvents) {
        if ([event.name isEqualToString:eventName]) {
            [events addObject:event];
        }
    }
    return events;
}

@end

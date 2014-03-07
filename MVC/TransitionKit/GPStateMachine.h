//
//  GPStateMachine.h
//  GreenMachine
//
//  Created by Daniel Beard on 1/31/14.
//  Copyright (c) 2014 Groupon Inc. All rights reserved.
//

#import "TransitionKit.h"

// Dictionary keys
extern NSString *const tkInitialState;
extern NSString *const tkStates;
extern NSString *const tkEnterBlock;
extern NSString *const tkExitBlock;
extern NSString *const tkExitTransitions;

/**
   This class serves a couple of different purposes:
    - Keep Groupon additions out of the TransitionKit library
    - Easier definition of TKStateMachine with the initWithDictionary: method
    - Allows generation of state change callbacks (similar to an informal protocol).
    - Allows multiple events with the same name (still have to have separate source/destination states)

   The dictionary passed to `initWithDictionary:` must contain a tkInitialState that must match a valid state.
   Valid states are defined in the dictionary `tkStates` keypath of the dictionary.
   A state can contain the following keys:
    - tkEnterBlock      : This is a block that is called on entry to the state
    - tkExitBlock       : This is a block that is called on exit from the state
    - tkExitTransitions : This is an array that contains transitions. There must be an equal number of objects in this array.
        - The first value in a pair denotes the state to be transitioned to
        - The second value in the pair denotes the event name that will cause this transition.

   A valid NSDictionary is as follows:

   NSDictionary *stateMachineDictionary = @{
     tkInitialState: @"launched",
     tkStates : @{
         @"launched": @{
         tkExitTransitions  : @[@"foreground", @"launchedInForeground",
         @"background", @"launchedInBackground"],
         },
             @"background": @{
             tkExitTransitions  : @[@"foreground", @"enterForeground"],
             },
             @"foreground": @{
             tkExitTransitions  : @[@"normal", @"finishUIAndNetworkSetup"],
             },
                 @"normal": @{
                 tkExitTransitions  : @[@"hibernate", @"enterBackground"],
                 },
                     @"hibernate": @{
                     tkEnterBlock       : [^(TKState *state, TKTransition *transition) {
                        [object sendMessage];
                     } copy],
                     tkExitTransitions  : @[@"normal", @"enterForeground"],
                     },
     },
   };

   Note: Here, we are using indentation to make the definition more readable, and implicitly denote 'child' and 'parent' states.
   Note:  There is a lack of tkEnterBlock and tkExitBlock values, there is a method named `setTranslatesEnterExitEventsToSelectorsForTarget:`
        Setting the target with this method allows state change based callbacks.
        E.g. Using the dictionary defined above and we wanted to do something on entry to the 'background' state. We would define the following method on our target:

        - (void)stateMachine:(id)stateMachine didEnterBackgroundState:(id)state transition:(id)transition;

        The state machine will dynamically build selectors based on state names, so if your target declares matching selectors for states, they will be called automatically.
        This is similar to an informal protocol that are sometimes used in Cocoa.

   It is also possible to set enter / exit blocks in the dictionary definition. See the tkEnterBlock in the hibernate state.
   Note: DON'T FORGET TO COPY THE BLOCK.

 */
@interface GPStateMachine : TKStateMachine

/**
   Convenience method for initializing a TKStateMachine object

   @param dictionary - The format dictionary that defines the states and transitions of the state machine
   @return an initialized TKStateMachine object
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

///---------------------------------
/// @name Auto generate method calls
///---------------------------------

/**
   Activates reflection-based enter/exit method calls.

   Setting the target here auto generates callbacks to that target. The purpose of this is to enable much more terse state machine definition.

   E.g. If you have the state "launched", and you set the target before the state machine is activated:
   When the state enters the launched state, a method: `- (void)stateMachine:(TKStateMachine *)stateMachine didEnterLaunchedState:(TKState *)state withTransition:(TKTransition *)transition` will be called on your target, if it responds to that selector.

 */
- (void)setTranslatesEnterExitEventsToSelectorsForTarget:(id)target;

///---------------------------------
/// @name Auto generate method calls
///---------------------------------

/**
   Overridden method
   Calls super and then generates a state change callback for the initial state
 */
- (void)activate;

/**
   Overriden method
   Calls the super implementation, then generates the enter and exit state based callbacks for the appropriate states
 */
- (BOOL)fireEvent:(id)eventOrEventName userInfo:(NSDictionary *)userInfo error:(NSError *__autoreleasing *)error;

@end

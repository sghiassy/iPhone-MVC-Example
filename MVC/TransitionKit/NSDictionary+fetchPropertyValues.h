//
//  NSDictionary+fetchPropertyValues.h
//
//  Created by Nathan Uno on 11/16/09.
//  Copyright 2009 Groupon.com. All rights reserved.
//
//	fetchPropertyValues category for NSDictionary class
//

@class Currency;

@interface NSDictionary (fetchPropertyValues)

- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSNumber *)doubleAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)integerAsNumberForKey:(NSString *)key;
- (NSNumber *)integerAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)boolAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;

- (NSDate *)dateForKey:(NSString *)key usingFormatter:(NSDateFormatter *)formatter;
- (NSDate *)dateForKey:(NSString *)key usingFormatter:(NSDateFormatter *)formatter defaultValue:(NSDate *)defaultValue;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;

- (double)doubleForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (NSInteger)intForKey:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (long long)longLongForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (BOOL)boolForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (id)valueForKeyPathNotNull:(id)key;
- (id)objectForKeyNotNull:(id)key;
- (id)valueForKeyNotNull:(id)key;

- (Currency *)currencyForKey:(NSString *)key defaultValue:(Currency *)defaultValue;

@end
//
//  NSDictionary+fetchPropertyValues.m
//
//  Created by Nathan Uno on 11/16/09.
//  Copyright 2009 Groupon.com. All rights reserved.
//
//	fetchPropertyValues method for generated NSDictionary class
//

#import "NSDictionary+fetchPropertyValues.h"

@implementation NSDictionary (fetchPropertyValues)

- (NSString *)stringForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSString *)kCFNull) return nil;
        //else return obj;
        else if ([obj isKindOfClass:[NSString class]]) return obj;
        else return [obj description];
    }
    return nil;
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSString *)kCFNull) return defaultValue;
        //else return obj;
        else if ([obj isKindOfClass:[NSString class]]) return obj;
        else return [obj description];
    }
    return defaultValue;
}

- (NSNumber *)doubleAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSNumber *)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]] && ![obj isKindOfClass:[NSDecimalNumber class]]) return defaultValue;
        else return [NSNumber numberWithDouble:[obj doubleValue]];
    }
    return defaultValue;
}

- (NSNumber *)integerAsNumberForKey:(NSString *)key {
    NSNumber *ret = nil;

    id       valueId = [self objectForKey:key];

    if (valueId != nil) {
        if ([valueId isKindOfClass:[NSNumber class]]) {
            ret = (NSNumber *)valueId;
        } else if ([valueId isKindOfClass:[NSString class]]) {
            NSString *valueStr = (NSString *)valueId;
            if ([valueStr length] > 0) {
                NSInteger valueInt = [valueStr integerValue];
                ret = [NSNumber numberWithInteger:valueInt];
            }
        }
    }

    return ret;
}

- (NSNumber *)integerAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSNumber *)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [NSNumber numberWithInteger:[obj integerValue]];
    }
    return defaultValue;
}

- (NSNumber *)boolAsNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSNumber *)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [NSNumber numberWithBool:[obj boolValue]];
    }
    return defaultValue;
}

- (NSDate *)dateForKey:(NSString *)key usingFormatter:(NSDateFormatter *)formatter {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSDate *)kCFNull) return nil;
        else if (![obj isKindOfClass:[NSString class]]) return nil;
        else return [formatter dateFromString:(NSString *)obj];
    }
    return nil;
}

- (NSDate *)dateForKey:(NSString *)key usingFormatter:(NSDateFormatter *)formatter defaultValue:(NSDate *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (NSDate *)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [formatter dateFromString:(NSString *)obj];
    }
    return defaultValue;
}

- (NSArray *)arrayForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return nil;
        else if (![obj isKindOfClass:[NSArray class]]) return nil;
        else return obj;
    }
    return nil;
}

- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSArray class]]) return defaultValue;
        else return obj;
    }
    return defaultValue;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return nil;
        else if (![obj isKindOfClass:[NSDictionary class]]) return nil;
        else return obj;
    }
    return nil;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSDictionary class]]) return defaultValue;
        else return obj;
    }
    return defaultValue;
}

- (double)doubleForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return 0.0;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]] && ![obj isKindOfClass:[NSDecimalNumber class]]) return 0.0;
        else return [obj doubleValue];
    }
    return 0.0;
}

- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]] && ![obj isKindOfClass:[NSDecimalNumber class]]) return defaultValue;
        else return [obj doubleValue];
    }
    return defaultValue;
}

- (NSInteger)intForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return 0;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return 0;
        else return [obj integerValue];
    }
    return 0;
}

- (NSInteger)intForKey:(NSString *)key defaultValue:(int)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [obj integerValue];
    }
    return defaultValue;
}

- (long long)longLongForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return 0;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return 0;
        else return [obj longLongValue];
    }
    return 0;
}

- (long long)longLongForKey:(NSString *)key defaultValue:(long long)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [obj longLongValue];
    }
    return defaultValue;
}

- (BOOL)boolForKey:(NSString *)key {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return NO;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return NO;
        else return [obj boolValue];
    }
    return NO;
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    id obj = [self valueForKey:key];

    if (obj) {
        if (obj == (id)kCFNull) return defaultValue;
        else if (![obj isKindOfClass:[NSNumber class]] && ![obj isKindOfClass:[NSString class]]) return defaultValue;
        else return [obj boolValue];
    }
    return defaultValue;
}

- (id)valueForKeyPathNotNull:(id)key {
    id object = [self valueForKeyPath:key];

    if (object == [NSNull null])
        return nil;

    return object;
}

// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];

    if (object == [NSNull null])
        return nil;

    return object;
}

- (id)valueForKeyNotNull:(id)key {
    id object = [self valueForKey:key];

    if (object == [NSNull null])
        return nil;

    return object;
}

@end

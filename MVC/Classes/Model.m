//
//  Model.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "Model.h"


@interface Model ()

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *consumerPrice;
@property (strong, nonatomic) NSNumber *discountPrice;
@property (strong, nonatomic) NSNumber *vendorPrice;
@property (assign, nonatomic) BOOL discountPriceActive;
@property (strong, nonatomic) NSString *host;

@end


@implementation Model

#pragma mark - Setters

- (void)setPriceInfo:(NSDictionary *)priceInfo {
    for (id key in priceInfo) {
        if ([key isEqualToString:@"consumerPrice"]) {
            self.consumerPrice = [self convertToNSNumber:[priceInfo objectForKey:key]];
        } else if ([key isEqualToString:@"discountPrice"]) {
            self.discountPrice = [self convertToNSNumber:[priceInfo objectForKey:key]];
        } else if ([key isEqualToString:@"discountPriceActive"]) {
            self.discountPriceActive = [[priceInfo objectForKey:key] isEqualToString:@"1.0"];
        } else if ([key isEqualToString:@"vendorPrice"]) {
            self.vendorPrice = [self convertToNSNumber:[priceInfo objectForKey:key]];
        }
    }

    self.price = [self setBeerPrice:self.discountPriceActive discountPrice:self.discountPrice consumerPrice:self.consumerPrice];
}

- (NSNumber *)convertToNSNumber:(NSString *)string {
    NSNumber *number = [[NSNumber alloc] initWithDouble:[string doubleValue]];
    return number;
}

- (NSNumber *)setBeerPrice:(BOOL)discountIsActive discountPrice:(NSNumber *)discountPrice consumerPrice:(NSNumber *)consumerPrice {
    NSNumber *price;

    if (discountIsActive) {
        price = [discountPrice copy];
    } else {
        price = [consumerPrice copy];
    }

    return price;
}

- (void)setProductInfo:(NSDictionary *)productInfo {
    for (id key in productInfo) {
        if ([key isEqualToString:@"id"]) {
            self.ID = [productInfo objectForKey:key];
        } else if ([key isEqualToString:@"image"]) {
            self.image = [productInfo objectForKey:key];
        } else if ([key isEqualToString:@"name"]) {
            self.name = [productInfo objectForKey:key];
        } else if ([key isEqualToString:@"rating"]) {
            self.rating = [productInfo objectForKey:key];
        } else if ([key isEqualToString:@"type"]) {
            self.type = [productInfo objectForKey:key];
        }
    }
}

- (void)setHost:(NSString *)host {
    _host = [host copy];
}

#pragma mark - Getters

- (NSString *)getName {
    return [self.name copy];
}

- (NSString *)getPrice {
    return [NSString stringWithFormat:@"%.2f", [self.price floatValue]];
}

- (NSString *)getImageUrl {
    return [NSString stringWithFormat:@"%@%@", self.host, self.image];
}

@end

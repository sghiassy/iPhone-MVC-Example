//
//  Model.m
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import "Model.h"


@interface Model ()

/**
 *  In real-world settings, you would want to convert each value to a proper typed variable
 *  instead of just stuffing in the dictionary
 */
@property (strong, nonatomic) NSDictionary *priceDict;
@property (strong, nonatomic) NSDictionary *productDict;
@property (strong, nonatomic) NSString *host;
@property (strong, nonatomic) NSString *price;

@end

@implementation Model

#pragma mark - Setters

- (void)setPriceInfo:(NSDictionary *)priceInfo {
    self.priceDict = [priceInfo copy];

    BOOL isDiscountActive = [[self.priceDict objectForKey:@"discountPriceActive"] integerValue] == 1;
    self.price = [self setBeerPrice:isDiscountActive
                      discountPrice:[self.priceDict objectForKey:@"discountPrice"]
                      consumerPrice:[self.priceDict objectForKey:@"consumerPrice"]];
}

- (NSString *)setBeerPrice:(BOOL)discountIsActive discountPrice:(NSString *)discountPrice consumerPrice:(NSString *)consumerPrice {
    NSString *price;

    if (discountIsActive) {
        price = [discountPrice copy];
    } else {
        price = [consumerPrice copy];
    }

    return price;
}

- (void)setProductInfo:(NSDictionary *)productInfo {
    self.productDict = productInfo;
}

- (void)setHost:(NSString *)host {
    _host = [host copy];
}

#pragma mark - Getters

- (NSString *)getName {
    return [[self.priceDict objectForKey:@"name"] copy];
}

- (NSString *)getPrice {
    return [NSString stringWithFormat:@"%.2f", [self.price floatValue]];
}

- (NSString *)getImageUrl {
    return [NSString stringWithFormat:@"%@%@", self.host, [self.productDict objectForKey:@"image"]];
}

@end

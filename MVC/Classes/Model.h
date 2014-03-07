//
//  Model.h
//  MVC
//
//  Created by Shaheen Ghiassy on 3/6/14.
//  Copyright (c) 2014 Shaheen Ghiassy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

#pragma mark - Setters
- (void)setPriceInfo:(NSDictionary *)priceInfo;
- (void)setProductInfo:(NSDictionary *)productInfo;
- (void)setHost:(NSString *)host;

#pragma mark - Getters
- (NSString *)getName;
- (NSString *)getPrice;
- (NSString *)getImageUrl;

@end

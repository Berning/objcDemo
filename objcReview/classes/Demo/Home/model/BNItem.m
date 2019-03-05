//
//  BNItem.m
//  objcReview
//
//  Created by Berning on 2018/12/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNItem.h"

@implementation BNItem

+ (instancetype)itemWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}




@end

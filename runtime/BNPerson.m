//
//  BNPerson.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNPerson.h"

@implementation BNPerson

-(instancetype)init
{
    self=[super init ];
    if (!self) {
        return nil;
    }
    self.age=20;
    self.arr=@[@"wbn",@"wbn's gf"];
    return  self;
}

-(id)compute
{
    return @"20";
}

+(instancetype)person
{
    static dispatch_once_t onceToken;
    static BNPerson *person=nil;
    dispatch_once(&onceToken, ^{
        person=[self new];
    });
    return person;
}



@end

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

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kName];
    [aCoder encodeObject:self.height forKey:kHeight];
    [aCoder encodeObject:self.weight forKey:kWeight];
    [aCoder encodeInt:self.age forKey:kAge];
    

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:kName];
        self.height=[aDecoder decodeObjectForKey:kHeight];
        self.weight=[aDecoder decodeObjectForKey:kWeight];
        self.age=[aDecoder decodeIntForKey:kAge];
        
    }
    
    return self;
}



@end

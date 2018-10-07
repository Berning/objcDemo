//
//  BNPerson.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kName=@"kName";
static NSString *const kHeight=@"kHeight";
static NSString *const kWeight=@"kWeight";
static NSString *const kAge=@"kAge";

@class BNDog;


@interface BNPerson : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *tclass;
@property(nonatomic,copy)NSString *gf;
@property(nonatomic,assign)int  age;

@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *weight;

@property(nonatomic,assign)int  ID;

@property(nonatomic,strong)NSDate *createDate;

@property(nonatomic,strong)NSArray  *arr;

@property(nonatomic ,strong)BNDog *dog;

@property(nonatomic,strong)NSArray *books;

+(instancetype)person;

-(id)compute;

@end

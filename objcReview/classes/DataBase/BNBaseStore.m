//
//  BNBaseStore.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNBaseStore.h"
#import "BNPerson.h"

@implementation BNBaseStore

+(void)test
{
    [self storeForPlist];
//    [self storeForPreference];
//    [self storeForArchiver];
}


+(void)storeForPlist
{
//    只能存储 NSString,NSArray,NSDictionary,NSData,NSDate,NSNumber,Boolean
    NSString *str=[NSString stringWithFormat:@"good job"];
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[path stringByAppendingPathComponent:@"berning.plist"];
    NSLog(@"filepath:%@",filePath);
//    //自定义 ，不可行
//    BNPerson *p=[BNPerson person];
    

    NSMutableArray *arr=[NSMutableArray array];
    //1.
    [arr addObject:str];
    //2.
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    for (int i=0; i<10; i++) {
        [dict setObject:[NSString stringWithFormat:@"ob%i",i] forKey:[NSString stringWithFormat:@"k%i",i]];

    }
    [arr addObject:dict];
    
    //3.
    NSArray *sArr=[NSArray arrayWithObjects:@"wbn",@"wxx",@"xx",@"bn", nil];
    [arr addObject:sArr];
    [arr writeToFile:filePath atomically:YES];
    
    NSLog(@"plist:%@",    [NSArray arrayWithContentsOfFile:filePath]);
}


+(void)storeForPreference
{
    //系统类型
    NSString *str=[NSString stringWithFormat:@"good job"];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:str];
    [arr addObject:@"cfffffff"];

    //自定义(不可行)
//    BNPerson *p=[BNPerson person];
//    p.name=@"wbn";
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:arr forKey:@"k1"];
    [userDefaults setObject:str forKey:@"k2"];
//    [userDefaults setObject:p forKey:@"person"];
    [userDefaults synchronize];
    
    
    NSLog(@"%@\n%@",[userDefaults objectForKey:@"k1"],[userDefaults objectForKey:@"k2"]);
    NSLog(@"%@\n%@",[userDefaults arrayForKey:@"k1"],[userDefaults stringForKey:@"k2"]);
    NSLog(@"%@",[userDefaults objectForKey:@"person"]);
}

+(void)storeForArchiver
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"path:%@",path);
    NSString *filePath=[path stringByAppendingPathComponent:@"archiver"];

    BNPerson *p=[BNPerson person];
    p.name=@"wbn";
    p.age=12;
    [NSKeyedArchiver archiveRootObject:p toFile:filePath];
    
    BNPerson *getP=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"p:%@,%d", getP.name,getP.age);
    
}

@end

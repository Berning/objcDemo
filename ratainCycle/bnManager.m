//
//  bnManager.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnManager.h"
#import "bnPerson.h"
#import "bnMachine.h"

@implementation bnManager
-(void)test
{
    bnPerson *person=[bnPerson new];
    bnMachine *machine=[bnMachine new];
    person.delegate=machine;
    
    [person release];
    [machine release];
}

+(void)filterArr:(NSArray *)array
{
    NSMutableArray *arr=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([array indexOfObject:obj]==idx)
        {
            [arr addObject:obj];
            
        }
    }];
    NSLog(@"%@",array);
    
    NSLog(@"%@",arr);
}


@end

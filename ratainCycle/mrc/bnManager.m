//
//  bnManager.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#if !__has_feature(objc_arc)

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



@end
#endif

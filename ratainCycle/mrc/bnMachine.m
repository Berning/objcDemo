//
//  bnMachine.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//
#if !__has_feature(objc_arc)


#import "bnMachine.h"

@implementation bnMachine

-(void)dealloc
{
    NSLog(@"pre:%@",[self class]);
    [super dealloc];
    NSLog(@"suf:%@",[self class]);

}
@end

#endif

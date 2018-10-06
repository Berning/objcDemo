//
//  bnPerson.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnPerson.h"

@implementation bnPerson

-(void)dealloc
{
    self.delegate=nil;
    NSLog(@"bnPerson dealloc");
    [super dealloc];
}


@end

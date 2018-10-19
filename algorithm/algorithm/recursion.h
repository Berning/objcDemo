//
//  recursion.h
//  algorithm
//
//  Created by uBerning on 16/12/30.
//  Copyright © 2016年 360. All rights reserved.
//递归算法

#import <Foundation/Foundation.h>

@interface recursion : NSObject

int recursionf(int i);

void hanoi(int n,int p1,int p2,int p3);

void Perm(int list[],int k,int m);

long Fibonaci(int n);

void recursionTest(int low ,int high); //快排中用到

@end

//
//  recursion.h
//  algorithm
//
//  Created by uBerning on 16/12/30.
//  Copyright © 2016年 360. All rights reserved.
//递归算法

//递归进层三件事：保存本层参数、返回地址;
//　　传递参数，分配局部数据空间;
//　　控制转移。
//递归退层三件事：恢复上层；
//　　　　　　　　传递结果；
//　　　　　　　　转断点执行。


#import <Foundation/Foundation.h>

@interface recursion : NSObject

int recursionf(int i);

void hanoi(int n,int p1,int p2,int p3);

void Perm(int list[],int k,int m);

long Fibonaci(int n);

void recursionTest(int low ,int high); //快排中用到

@end

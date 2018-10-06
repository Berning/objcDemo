
//
//  recursion.m
//  algorithm
//
//  Created by uBerning on 16/12/30.
//  Copyright © 2016年 360. All rights reserved.
//

#import "recursion.h"

@implementation recursion

//n!    
int recursionf(int i)
{
    int sum = 0;
    if (0 == i)
        return (1);
    else
        sum = i * recursionf(i-1);
    return sum;
}

#warning problem
//汉诺塔
void hanoi(int n,int p1,int p2,int p3)
{
    if(1==n)
        printf("盘子从%d移到%d\n",p1,p3);
    else
    {
        hanoi(n-1,p1,p3,p2);
        printf("盘子从%d移到%d\n",p1,p3);

        hanoi(n-1,p2,p1,p3);
    }
}

#warning problem
//排列组合
void Perm(int list[],int k,int m)
{
    if (k == m-1)
    {
        for(int i=0;i<m;i++)
        {
            printf("%d",list[i]);
        }
        printf("n");
    }
    else
    {
        for(int i=k;i<m;i++)
        {
            swap(&list[k],&list[i]);
            Perm(list,k+1,m);
            swap(&list[k],&list[i]);
        }
    }
}


//斐波那契
long Fib(int n)
{
    long fibNum=0;
    if (0 == n)
        fibNum=0;
    if (1 == n)
        fibNum= 1;
    if (n > 1)
        fibNum= Fib(n-1) + Fib(n-2);
    return fibNum;
}


//360面试
-(void)printViews:(UIView *)view
{
    //      NSArray *viewArray=[view subviews];
    for (id childView in [view subviews]) {
        NSLog(@"%@",childView);
        if ([[childView subviews] count]!=0) {
            [self printViews:childView];
        }
    }
}

@end

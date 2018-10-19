
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
long Fibonaci(int n)
{
    long fibNum=0;
    if (0 == n)
        fibNum=0;
    if (1 == n)
        fibNum= 1;
    if (n > 1)
        fibNum= Fibonaci(n-1) + Fibonaci(n-2);
    return fibNum;
}


//360面试
//-(void)printViews:(UIView *)view
//{
//    //      NSArray *viewArray=[view subviews];
//    for (id childView in [view subviews]) {
//        NSLog(@"%@",childView);
//        if ([[childView subviews] count]!=0) {
//            [self printViews:childView];
//        }
//    }
//}


int partition1(int low,int high)
{
    low++;
    
    return low;
}

void recursionTest(int low ,int high)  //快排中用到
{
    printf("low=%d,high=%d",low,high);
    if(low<high)
    {
        printf("--------------------调用成功\n\n\n");
        int pivot=partition1(low, high);
        
        printf("================first recursion================\n");
        printf("pivot=%d\n",pivot);

        recursionTest(pivot, high-1);   //第一次递归成功几次（即产生几个pivot），待第二次递归失败，就回来再调用几次第一个递归，调用完之后再进行第二个递归。
        
        printf("--------------------调用失败\n\n\n");
        printf("================second recursion================\n");
        
        recursionTest(pivot, high);
    }
    
}

@end


//
//  recursion.m
//  algorithm
//
//  Created by uBerning on 16/12/30.
//  Copyright © 2016年 360. All rights reserved.
//

#import "recursion.h"


@implementation recursion

int n = 0;

/**
 全排列

 @param list 数组
 @param k 传0,代表从第0个元素开始
 @param m 数组长度-1
 */
void perm(int list[], int k, int m)
{
    int i;
    if(k==m)
    {
        for(i=0; i<=m; i++)
            printf("%d ", list[i]);
        printf("\n");
        n++;
    }
    else
    {
        for(i=k; i<=m; i++)
        {
            swap(&list[k], &list[i]);
            perm(list, k + 1, m);
            swap(&list[k], &list[i]);
        }
    }
}

void testPerm()
{
    int list[]={1,2,3};
    perm(list, 0,sizeof(list)/sizeof(list)[0]-1);
    printf("total:%d\n",n);
    
}




int c=0;
/**
 组合

 @param index 表示某个组合中的索引
 @param begin 表示从数组A中begin位置开始寻找
 @param n 表示数组长度
 @param m  表示组合中个数
 @param A 表示原数组
 @param C 表示组合数组
 */
void Comb(int index,int begin,int n,int m,int *A,int *C)
{
     if(index==m)
    {
        for(int i=0;i<m;i++)
            printf("%d ",C[i]);
        printf("\n");
        c++;
        return;
    }
    for(int j=begin;j<=n-m+index;j++)
    {
        C[index]=A[j];
        Comb(index+1,j+1,n,m,A,C);
    }
}

void testComb()
{
    int A[]={1,2,3,4,5,6,7};
    int m=3;
    int *C=(int *)malloc(m*sizeof(int));  //int *C=new int[m+1];
    Comb(0,0,sizeof(A)/sizeof(A)[0],m,A,C);
    printf("total:%d\n",c);
    free(C);                      //delete []C;
}


//阶乘n!
int factorial(int n)
{
    if (n<=1)
        return 1;
    return n*factorial(n-1);
}

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


//斐波那契
long Fibonaci(int n)
{
    if(n<2)
        return 1;
    return Fibonaci(n-1) + Fibonaci(n-2);
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


@end

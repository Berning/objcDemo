
//
//  recursion.m
//  algorithm
//
//  Created by uBerning on 16/12/30.
//  Copyright © 2016年 360. All rights reserved.
//

#import "recursion.h"

@implementation recursion

//排列
int n = 0;
void perm(int list[], int k, int m) {
    int i;
    if(k > m)  {
        for(i = 0; i <= m; i++)
            printf("%d ", list[i]);
        printf("\n");
        n++;
    }
    else {
        for(i = k; i <= m; i++)     {
            swap(&list[k], &list[i]);
            perm(list, k + 1, m);
            swap(&list[k], &list[i]);
        }
    }
}

void testPerm()
{
    int list[]={1,2,3,4,5};
    perm(list, 0, 4);
    printf("total:%d\n",n);
}

//递归组合
void Comb(int index,int begin,int len,int n,int *A,int *C)
{
    // index表示某个组合中的索引，begin表示从数组A中begin位置开始寻找， // len表示数组A长度，n表示组合中个数，A表示原数组，C表示组合数组
    if(index==n)
    {
        for(int i=0;i<n;i++)
            printf("%d ",C[i]);
        printf("\n");
        return;
    }
    for(int j=begin;j<=len-n+index;j++)
    {
        C[index]=A[j];
        Comb(index+1,j+1,len,n,A,C);
    }
}

void testComb()
{
    int A[5]={1,2,3,4,5};
    int len=5,n=3;
    int *C=(int *)malloc((n+1)*sizeof(int));  //int *C=new int[n+1];
    Comb(0,0,len,n,A,C);
    
    free(C);                      //delete []C;

}


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

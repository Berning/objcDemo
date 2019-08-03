//
//  fibnociSearch.m
//  algorithm
//
//  Created by Berning on 2018/10/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "fibnociSearch.h"

const int max_size=20;//斐波那契数组的长度

@implementation fibnociSearch

/*构造一个斐波那契数组*/
void Fibonacci(int * F)
{
    F[0]=0;
    F[1]=1;
    for(int i=2;i<max_size;++i)
        F[i]=F[i-1]+F[i-2];
}

/*定义斐波那契查找法*/
int Fibonacci_Search(int *a, int n, int key)
{
    int low=0;
    int high=n-1;
    
    int F[max_size];
    Fibonacci(F);//构造一个斐波那契数组F
    
    int k=0;
    while(n>F[k]-1)//计算n位于斐波那契数列的位置
        ++k;
    
    int  * temp;//将数组a扩展到F[k]-1的长度
    
    temp=(int *)malloc(sizeof(int)*(F[k]-1));
    memcpy(temp,a,n*sizeof(int));
    
    for(int i=n;i<F[k]-1;++i)
        temp[i]=a[n-1];
    
    while(low<=high)
    {
        int mid=low+F[k-1]-1;
        if(key<temp[mid])
        {
            high=mid-1;
            k-=1;
        }
        else if(key>temp[mid])
        {
            low=mid+1;
            k-=2;
        }
        else
        {
            if(mid<n)
                return mid; //若相等则说明mid即为查找到的位置
            else
                return n-1; //若mid>=n则说明是扩展的数值,返回n-1
        }
    }
    
    free(temp);
    return -1;
}

@end

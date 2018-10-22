//
//  search.m
//  algorithm
//
//  Created by Berning on 2018/10/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "search.h"

@implementation search

//顺序查找
//ps：顺序查找适合于存储结构为顺序存储或链接存储的线性表。
//复杂度：O(n）
int bnSeqSearch(int a[], int value, int n)
{
    int i;
    for(i=0; i<n; i++)
        if(a[i]==value)
            return i;
    return -1;
}

//二分查找（折半查找）
//ps:1.要求线性表顺序存储；2.有序排列
//复杂度分析：最坏情况下，关键词比较次数为log2(n+1)，且期望时间复杂度为O(log2n)；
int bnBinarySearch(int a[], int value, int n)
{
    int low, high, mid;
    low = 0;
    high = n-1;
    while(low<=high)
    {
        mid =low+(high-low)/2;//直接使用（high+low)/2,当high较大时,会超出表达式所能表示的类型,导致错误。
        printf("mid:%d\n",mid);
        if(a[mid]==value)
            return mid;
        if(a[mid]>value)
            high = mid-1;
        if(a[mid]<value)
            low = mid+1;
    }
    return -1;
}

//二分查找，递归版本
int bnBinarySearchRecursion(int a[], int value, int low, int high)
{
    int mid = low+(high-low)/2;
    printf("mid:%d\n",mid);

    if(a[mid]==value)
        return mid;
    if(a[mid]>value)
        return bnBinarySearchRecursion(a, value, low, mid-1);
    if(a[mid]<value)
        return bnBinarySearchRecursion(a, value, mid+1, high);
    return -1;
}

//插值查找
//基本思想：基于二分查找算法，将查找点的选择改进为自适应选择，可以提高查找效率。当然，差值查找也属于有序查找。
//将二分查找中1/2改进：(value-a[low])/(a[high]-a[low]);
//注：对于表长较大，而关键字分布又比较均匀的查找表来说，插值查找算法的平均性能比折半查找要好的多。反之，数组中如果分布非常不均匀，那么插值查找未必是很合适的选择。
//复杂度分析：查找成功或者失败的时间复杂度均为O(log2(log2n))。

int bnInsertionSearch(int a[], int value, int low, int high)
{
    int mid = low+(value-a[low])/(a[high]-a[low])*(high-low);
    printf("mid:%d\n",mid);

    if(a[mid]==value)
        return mid;
    if(a[mid]>value)
        return bnInsertionSearch(a, value, low, mid-1);
    if(a[mid]<value)
        return bnInsertionSearch(a, value, mid+1, high);
    return -1;
}



@end

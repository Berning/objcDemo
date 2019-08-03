//
//  sort.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//常见排序算法

#import <Foundation/Foundation.h>

@interface sort : NSObject

//插入
void bnInsertionSort(int a[],int n);

void bnShellSort(int a[], int n);

//选择
void bnSelectSort(int a[],int n) ;

void bnSelectSortS(int a[],int n);
void bnHeapSort(int a[],int n);

//交换
void bnBubbleSort(int a[], int n);
void bnBubbleSort_while( int a[], int n) ;
void bnBubbleSort_Cocktail( int a[], int n);

void bnQuickSort(int a[],int n);
void bnQuickSort_improve(int a[], int n);

//归并
void bnMergeSort(int a[], int n);

//基数（桶）
void bnBucketSort(int a[], int n);


@end

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
void InsertionSort(int a[],int n);
void shellSort(int a[], int n);

//选择
void SelectSort(int r[],int n) ;

//交换
void bubbleSort(int a[], int n);
void bubbleSort_1 ( int r[], int n) ;
void bubbleSort_2 ( int r[], int n);

void quickSort(int a[], int low, int high);
void quickSort1(int r[], int n, int k);




@end

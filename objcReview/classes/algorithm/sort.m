//
//  sort.m
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

#import "sort.h"

@implementation sort


//直接插入排序
void InsertionSort(int a[],int n)
{
    ePrint(a, 10);
    for(int i= 1; i<n; i++){
        if(a[i] < a[i-1]){               //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j= i-1;
            int x = a[i];        //复制为哨兵，即存储待排序元素
            //            a[i] = a[i-1];           //先后移一个元素
            while(j>=0&&x < a[j]){  //查找在有序表的插入位置
                a[j+1] = a[j];
                j--;         //元素后移
            }
            a[j+1] = x;      //插入到正确位置
        }
        ePrint (a,n);           //打印每趟排序的结果
    }
    
    ePrint(a, 10);
    eLine
    
}


#warning --p有点问题
//希尔排序
void ShellInsertSort(int a[], int n, int dk)
{
    for(int i= dk; i<n; ++i){
        if(a[i] < a[i-dk]){          //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j = i-dk;
            int x = a[i];           //复制为哨兵，即存储待排序元素
            a[i] = a[i-dk];         //首先后移一个元素
            while(x < a[j]){     //查找在有序表的插入位置
                a[j+dk] = a[j];
                j -= dk;             //元素后移
            }
            a[j+dk] = x;            //插入到正确位置
        }
        ePrint(a, n );
    }
    
}

/**
 * 先按增量d（n/2,n为要排序数的个数进行希尔排序
 *
 */
void shellSort(int a[], int n){
    
    int dk = n/2;
    while( dk >= 1  ){
        ShellInsertSort(a, n, dk);
        dk = dk/2;
    }
}

#pragma 选择排序

//简单选择排序
void SelectSort(int r[],int n) {
    int i ,j , min ,max;
    for (i=1 ;i <= n/2;i++) {
        // 做不超过n/2趟选择排序
        min = i; max = i ; //分别记录最大和最小关键字记录位置
        for (j= i+1; j<= n-i; j++) {
            if (r[j] > r[max]) {
                max = j ; continue ;
            }
            if (r[j]< r[min]) {
                min = j ;
            }
        }
        //该交换操作还可分情况讨论以提高效率
        swap(&r[i-1],  &r[min]);
        swap(&r[n-i],  &r[max]);

//        tmp = r[i-1]; r[i-1] = r[min]; r[min] = tmp;
//        tmp = r[n-i]; r[n-i] = r[max]; r[max] = tmp;
        
    }
}

//堆排序

//冒泡排序
void bubbleSort(int a[], int n){
    for(int i =0 ; i< n-1; ++i) {
        for(int j = 0; j < n-i-1; ++j) {
            if(a[j] > a[j+1])
            {
                swap(&a[j], &a[j+1]);
//                int tmp = a[j] ; a[j] = a[j+1] ;  a[j+1] = tmp;
            }
        }
    }
}

void bubbleSort_1 ( int r[], int n) {
    int i= n -1;  //初始时,最后位置保持不变
    while ( i> 0) {
        int pos= 0; //每趟开始时,无记录交换
        for (int j= 0; j< i; j++)
            if (r[j]> r[j+1]) {
                pos= j; //记录交换的位置
                swap(&r[j], &r[j+1]);
            }
        i= pos; //为下一趟排序作准备
    }
}
void bubbleSort_2 ( int r[], int n){
    int low = 0;
    int high= n -1; //设置变量的初始值
    while (low < high) {
        for (int j= low; j< high; ++j) //正向冒泡,找到最大者
            if (r[j]> r[j+1]) {
                NSLog(@"high--%d,",high);
                swap(&r[j], &r[j+1]);
            }
        --high;                 //修改high值, 前移一位
        for (int  j=high; j>low; --j) //反向冒泡,找到最小者
            if (r[j]<r[j-1]) {
                NSLog(@"low--%d,",low);
                
                swap(&r[j], &r[j-1]);
            }
        ++low;                  //修改low值,后移一位
    }
}
//快速排序


int partition(int a[], int low, int high)
{
    int privotKey = a[low];                             //基准元素
    while(low < high){                                   //从表的两端交替地向中间扫描
        while(low < high  && a[high] >= privotKey)
            --high;                                         //从high 所指位置向前搜索，至多到low+1 位置。将比             基准元素小的交换到低端
        swap(&a[low], &a[high]);
        ePrint(a,10);
        
        while(low < high  && a[low] <= privotKey )
        {
            ++low;
            
        }
        swap(&a[low], &a[high]);
        
    
        ePrint(a,10);
    }
    ePrint(a,10);
    return low;
}


void quickSort(int a[], int low, int high)
{
    if(low < high){
        int privotLoc = partition(a,  low,  high);  //将表一分为二
        printf("loc=%d",privotLoc);
        quickSort(a,  low,  privotLoc -1);          //递归对低子表递归排序
        quickSort(a,   privotLoc + 1, high);        //递归对高子表递归排序
    }
}



#warning --quickSortImprove
int * qsort_improve(int r[ ],int low,int high, int k)
{
    if( high -low > k ) { //长度大于k时递归, k为指定的数
        int pivot = partition(r, low, high); // 调用的Partition算法保持不变
        qsort_improve(r, low, pivot - 1,k);
        qsort_improve(r, pivot + 1, high,k);
    }
    return  r;
}
void quickSort1(int r[], int n, int k)
{
    r=qsort_improve(r,0,n-1,k);//先调用改进算法Qsort使之基本有序
    
    //    InsertionSort(r , 10);
    //再用插入排序对基本有序序列排序
    for(int i=1; i<n;i ++){
        int tmp = r[i];
        int j=i-1;
        while(j>=0&&tmp < r[j]){
            r[j+1]=r[j]; j=j-1;
        }
        r[j+1] = tmp;
    }
    
}






@end

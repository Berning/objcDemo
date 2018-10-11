//
//  sort.m
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

#import "sort.h"

@implementation sort


//插入排序为 向前排序 
//冒泡排序为 向后排序

#pragma mark 直接插入排序，希尔排序
void InsertionSort(int a[],int n)
{
    
    for(int i= 1; i<n; i++)
    {
        if(a[i] < a[i-1])
        {               //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j= i-1;
            int x = a[i];        //复制为哨兵，即存储待排序元素
            //            a[i] = a[i-1];           //先后移一个元素
            
            //核心块
            while(j>=0&&x < a[j])
            {  //查找在有序表的插入位置
                a[j+1] = a[j];
                j--;         //元素后移
            }
            a[j+1] = x;      //插入到正确位置
        }
        ePrint (a,n);           //打印每趟排序的结果
        ePrintNameM(i)
    }
    
    ePrint(a, n);
    ePrintName
    
}


#warning 有点问题
//希尔排序
void ShellInsertSort(int a[], int n, int dk)
{
    for(int i= dk; i<n; ++i)
    {
        if(a[i] < a[i-dk])
        {          //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j = i-dk;
            int x = a[i];           //复制为哨兵，即存储待排序元素
            a[i] = a[i-dk];         //首先后移一个元素
            while(x < a[j])
            {     //查找在有序表的插入位置
                a[j+dk] = a[j];
                j -= dk;             //元素后移
            }
            a[j+dk] = x;            //插入到正确位置
        }
        ePrint(a, n );
        ePrintNameM(i)
    }
    
}

/**
 * 先按增量d（n/2,n为要排序数的个数进行希尔排序
 *
 */
void shellSort(int a[], int n)
{
    
    int dk = n/2;
    while( dk >= 1  )
    {
        ShellInsertSort(a, n, dk);
        dk = dk/2;
    }
}

#pragma mark 选择排序（简单选择排序，堆排序）

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
        ePrint(r, n);
        ePrintNameM(i);

//        tmp = r[i-1]; r[i-1] = r[min]; r[min] = tmp;
//        tmp = r[n-i]; r[n-i] = r[max]; r[max] = tmp;
        
    }
    ePrint(r, n);
    ePrintName
}

//堆排序

#pragma mark 交换排序（冒泡，快排）

//冒泡排序
void bubbleSort(int a[], int n)
{
    for(int i =1 ; i< n; ++i)//i=1表示第1趟开始
    {
        for(int j = 0; j < n-i; ++j)//j为数据下标，所以必须0开始
        {
            if(a[j] > a[j+1])
            {
                swap(&a[j], &a[j+1]);
            }
        }
        ePrint(a, n);
        ePrintNameM(i);
    }

    ePrint(a, n);
    ePrintName

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
    static int i=1;
    int pivotKey = a[low];                             //基准元素
    while(low < high){                                   //从表的两端交替地向中间扫描
        while(low < high  && a[high] >= pivotKey)
            --high;        //从high 所指位置向前搜索，至多到low+1 位置。将比基准元素小的交换到低端
        swap(&a[low], &a[high]);
       
        ePrint(a,10);
        ePrintNameQuickS(i, "high")
        
        while(low < high  && a[low] <= pivotKey )
            ++low;
        swap(&a[low], &a[high]);
       
        ePrint(a,10);
        ePrintNameQuickS(i, "low");

    }
    ePrint(a,10);
    ePrintNameM(i)
    ++i;

    return low;
}


void quickSort(int a[], int low, int high)
{
    if(low < high){
        int pivotLoc = partition(a,  low,  high);  //将表一分为二
        printf("pivotLoc=%d,low=%d,high=%d\n",pivotLoc,low,high);
        quickSort(a,  low,  pivotLoc -1);          //递归对低子表递归排序
        quickSort(a,   pivotLoc + 1, high);        //递归对高子表递归排序
        

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


#pragma mark 归并排序


#pragma mark 基数排序













@end

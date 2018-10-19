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

//思想：在一个已排好序的记录子集的基础上，每一步将下一个待排序的记录有序地插入到已排好序的记录子集中，直到将所有待排记录全部插入为止
#pragma mark 插入排序(直接插入，希尔)
void bnInsertionSort(int a[],int n)
{
    
    for(int i= 1; i<n; i++)  //n-1次
    {
        if(a[i] < a[i-1])
        {               //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j= i-1;
            int x = a[i];        //，即存储待排序元素
            
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


//希尔排序
void ShellInsert(int a[], int n, int dk)
{
    for(int i= dk; i<n; ++i)
    {
        if(a[i] < a[i-dk])
        {          //若第i个元素大于i-1元素，直接插入。小于的话，移动有序表后插入
            int j = i-dk;
            int x = a[i];           //复制为哨兵，即存储待排序元素
            while(j>=0&&x < a[j])
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

//先按增量d（n/2,n为要排序数的个数进行希尔排序
//思想：先将待排序记录序列分割成若干个“较稀疏的”子序列，分别进行直接插入排序。经过上述粗略调整， 整个序列中的记录已经基本有序，最后再对全部记录进行一次直接插入排序。

void bnShellSort(int a[], int n)
{
    int dk = n/2;
    while( dk >= 1  )
    {
        ShellInsert(a, n, dk);
        dk = dk/2;
    }
}

#pragma mark 选择排序（简单选择排序，堆排序）
//思想：第i趟简单选择排序是指通过n-i次关键字的比较，从n-i+1 个记录中选出关键字最小的记录，并与第i个记录进行交换。
void bnSelectSort(int *a,int n)
{
    register int i,j,min;
    for(i = 0;i < n-1;i++)  //n-1次
    {
        min = i;//查找最小值
        for(j = i + 1;j < n;j++)   //n-1次
        {
            if(a[min] > a[j])
                min = j;
        }
        if(min != i)
        {
            swap(&a[min], &a[i]);
        }
        ePrint(a, n);
        ePrintNameM(i);
    }
}
//简单选择排序
void bnSelectSortS(int a[],int n) {
    int i ,j , min ,max;
    for (i=0;i<n/2;i++)        // 做不超过n/2趟选择排序
    {
        min = i; max = i ; //分别记录最大和最小索引
        for (j= i+1; j<n-i; j++)   //n-1次
        {
            if (a[j] > a[max])
            {
                max = j ; continue ;
            }
            if (a[j]< a[min]) {
                min = j ;
            }
        }
        printf("i=%d,max=%d,min=%d\n",i,max,min);

        //该交换操作还可分情况讨论以提高效率 max i-1 n-i min
        //6,1,5,3  i =0 ,max=0,min=1 /1 6 5 3/3 6 5 1
        swap(&a[i],&a[min]);
        max==i?(max=min):(max=max);
        swap(&a[n-1-i],&a[max]);
        
        ePrint(a, n);
        ePrintNameM(i);        
    }
    ePrint(a, n);
    ePrintName
}

//堆排序
void adjustHeap(int a[], int j, int param1)
{
    int temp=a[param1];
    for (int k=param1*2+1;k<j;k=k*2+1)
    {
        //如果右边值大于左边值，指向右边
        if (k+1<j && a[k]< a[k+1])
        {
            k++;
        }
        //如果子节点大于父节点，将子节点值赋给父节点,并以新的子节点作为父节点（不用进行交换）
        if (a[k]>temp)
        {
            a[param1]=a[k];
            param1=k;
        }
        else
            break;
    }
    //put the value in the final position
    a[param1]=temp;
}
//堆排序主要算法
void bnHeapSort(int a[],int n)
{
    //1.构建大顶堆
    for (int i=n/2-1;i>=0;i--)
    {
        //put the value in the final position
        adjustHeap(a,n,i);
        
        ePrint(a, n);
        ePrintNameM(i);
    }
    //2.调整堆结构+交换堆顶元素与末尾元素
    for (int j=n-1;j>0;j--)
    {
        //堆顶元素和末尾元素进行交换
        swap(&a[0], &a[j]);
        adjustHeap(a,j,0);//重新对堆进行调整
        
        ePrint(a, n);
        ePrintNameM(j);
    }
    
    ePrint(a, n);
    ePrintName
}

#pragma mark 交换排序（冒泡，快排）
//思想：从头扫描待排序记录序列， 在扫描的过程中顺次比较相邻的两个元素的大小
//冒泡排序 T(n)=O((n^2-n)/2)
void bnBubbleSort(int a[], int n)
{
    for(int i =1 ; i< n; ++i)//i=1表示第1趟开始   //n-1次
    {
        for(int j = 0; j < n-i; ++j)//j为数据下标，所以必须0开始   //n-1次
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

void bnBubbleSort_while( int a[], int n)
{
    int i= 1;  //初始时,最后位置保持不变
    while ( i<n)
    {
        for (int j= 0; j< n-i; j++)
            if (a[j]> a[j+1])
            {
                swap(&a[j], &a[j+1]);
            }
        i++; //为下一趟排序作准备
        ePrint(a, n);
        ePrintName
    }
}

//void bnBubbleSort_while ( int a[], int n)
//{
//    int i= n -1;  //初始时,最后位置保持不变
//    while ( i> 0)
//    {
//        int pos= 0; //每趟开始时,无记录交换
//        for (int j= 0; j< i; j++)
//            if (a[j]> a[j+1])
//            {
//                pos= j; //记录交换的位置
//                swap(&a[j], &a[j+1]);
//            }
//        i= pos; //为下一趟排序作准备
//    }
//}

//T(n)=O(n^2)
//鸡尾酒排序CocktailSort
void bnBubbleSort_Cocktail( int a[], int n)
{
    int low = 0;
    int high= n -1; //设置变量的初始值
    while (low < high)
    {
        for (int j= low; j< high; ++j) //正向冒泡,找到最大者
            if (a[j]> a[j+1])
            {
                swap(&a[j], &a[j+1]);

            }
        printf("high--%d\n",high);
        ePrint(a, n);
        ePrintName
        --high;                 //修改high值, 前移一位
        for (int  j=high; j>low; --j) //反向冒泡,找到最小者
            if (a[j]<a[j-1])
            {
                swap(&a[j], &a[j-1]);
            }
        printf("low--%d\n",low);
        ePrint(a, n);
        ePrintName
        ++low;                  //修改low值,后移一位
    }
}
//快速排序
//通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
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


void quickSort_invoke(int a[], int low, int high)
{
    printf("low--%d,high--%d",low,high);
    if(low < high)
    {
        printf("--------------------调用成功\n\n\n");
        int pivotLoc = partition(a,  low,  high);  //将表一分为二
        
        printf("================first recursion================\n");
        printf("pivotLoc=%d\n",pivotLoc);
        quickSort_invoke(a,low,pivotLoc -1);          //递归对低子表递归排序
        
        printf("--------------------调用失败\n\n\n");
        printf("================second recursion================\n");
        quickSort_invoke(a,pivotLoc + 1,high);        //递归对高子表递归排序
    }
}

void bnQuickSort(int *a,int n)
{
    int low=0,high=n-1;
    quickSort_invoke(a, low, high);
    printf("\n\nresult:\n");
    ePrint(a, n);
    ePrintName
}


int * qsort_improve_base(int a[ ],int low,int high, int k)
{
    if( high -low > k ) { //长度大于k时递归, k为指定的数
        int pivot = partition(a, low, high); // 调用的Partition算法保持不变
        qsort_improve_base(a, low, pivot - 1,k);
        qsort_improve_base(a, pivot + 1, high,k);
    }
    return  a;
}
void bnQuickSort_improve(int a[], int n)
{
    int k=3;//k传什么？
    a=qsort_improve_base(a,0,n-1,k);//先调用改进算法Qsort使之基本有序
    //再用插入排序对基本有序序列排序
    bnInsertionSort(a , n);
    ePrint(a, n);
    ePrintName;
    
}




#pragma mark 归并排序 (二路，多路)
//思想：该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为二路归并。

void Merge(int sourceArr[],int tempArr[], int startIndex, int midIndex, int endIndex)
{
    int i = startIndex, j=midIndex+1, k = startIndex;
    while(i!=midIndex+1 && j!=endIndex+1)
    {
        if(sourceArr[i] > sourceArr[j])
            tempArr[k++] = sourceArr[j++];
        else
            tempArr[k++] = sourceArr[i++];
    }
    while(i != midIndex+1)
        tempArr[k++] = sourceArr[i++];
    while(j != endIndex+1)
        tempArr[k++] = sourceArr[j++];
    for(i=startIndex; i<=endIndex; i++)
        sourceArr[i] = tempArr[i];
    
}

//内部使用递归
void MergeSort_recuision(int sourceArr[], int tempArr[], int startIndex, int endIndex)
{
    int midIndex;
    if(startIndex < endIndex)
    {
        midIndex = startIndex + (endIndex-startIndex) / 2;//避免溢出int
        MergeSort_recuision(sourceArr, tempArr, startIndex, midIndex);
        MergeSort_recuision(sourceArr, tempArr, midIndex+1, endIndex);
        Merge(sourceArr, tempArr, startIndex, midIndex, endIndex);
    }
    
}

void bnMergeSort(int a[],int n)
{
    int temp[n];
    MergeSort_recuision(a, temp, 0, n-1);
    ePrint(a, n);;
    ePrintName

}
#warning bug
#pragma mark 基数排序 （计数，基数，桶）
//获取数字的位数
//基数排序（radix sort）属于“分配式排序”（distribution sort），又称“桶子法”（bucket sort）或bin sort，顾名思义，它是透过键值的部份资讯，将要排序的元素分配至某些“桶”中，藉以达到排序的作用

int getLoopTimes(int num)
{
    int count = 1;
    int temp = num / 10;
    while(temp != 0)
    {
        count++;
        temp = temp / 10;
    }
    return count;
}

//查询数组中的最大数
int bnMax(int *a, int n)
{
    int i;
    int max = 0;
    for(i = 0; i < n; i++)
    {
        if(*(a + i) > max)
        {
            max = *(a + i);
        }
    }
    return max;
}
//将数字分配到各自的桶中，然后按照桶的顺序输出排序结果
void bucketSortOperation(int *a, int n, int loop)
{
    //建立一组桶此处的20是预设的根据实际数情况修改
    int buckets[10][20] = {};
    //求桶的index的除数
    //如798个位桶index=(798/1)%10=8
    //十位桶index=(798/10)%10=9
    //百位桶index=(798/100)%10=7
    //tempNum为上式中的1、10、100
    int tempNum = (int)pow(10, loop - 1);
    int i, j;
    for(i = 0; i < n; i++)
    {
        int row_index = (*(a + i) / tempNum) % 10;
        for(j = 0; j < 20; j++)
        {
            if(buckets[row_index][j] == NULL)
            {
                buckets[row_index][j] = *(a + i);
                break;
            }
        }
    }
    //将桶中的数，倒回到原有数组中
    int k = 0;
    for(i = 0; i < 10; i++)
    {
        for(j = 0; j < 20; j++)
        {
            if(buckets[i][j] != NULL)
            {
                *(a + k) = buckets[i][j];
                buckets[i][j] = NULL;
                k++;
            }
        }
    }
}


//基数排序

void bnBucketSort(int a[], int n)
{
    int maxNum = bnMax(a, n);
    int loopTimes = getLoopTimes(maxNum);
    int loop;
    //对每一位进行桶分配
    for(loop = 1; loop<= loopTimes; loop++)
    {
        bucketSortOperation(a, n, loop);
    }
    ePrint(a, n);;
    ePrintName

}



@end

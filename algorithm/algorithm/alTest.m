//
//  alTest.m
//  algorithm
//
//  Created by Berning on 2018/10/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "alTest.h"
#import "algorithm.h"
@implementation alTest

+(void)test
{
    [stringHandle test];
//    [self algorithmTest];

}

+(void)algorithmTest
{
    int arr[]={0,1,2,3,4,5,6,7,8,9};
    ePrint(arr, ARRAY_SIZE(arr));
    ePrintName;
    shuffle(arr,ARRAY_SIZE(arr));
    
    //    int arr[]={4, 9, 7 ,0, 6, 2, 8, 3, 1, 5};
    //    ePrint(arr, ARRAY_SIZE(arr));
    //    ePrintName
    
    printf("================initial invoke================\n");
    
#pragma  mark insert
    //    bnInsertionSort(arr, ARRAY_SIZE(arr));
    //    bnShellSort(arr, ARRAY_SIZE(arr));
#pragma  mark select
    //    bnSelectSort(arr, ARRAY_SIZE(arr));
    //    bnSelectSortS(arr, ARRAY_SIZE(arr));
    //    bnHeapSort(arr, ARRAY_SIZE(arr));
#pragma  mark exchange
    //    bnBubbleSort(arr, ARRAY_SIZE(arr));
    //    bnBubbleSort_while(arr, ARRAY_SIZE(arr));
    //    bnBubbleSort_Cocktail(arr, ARRAY_SIZE(arr));
    //    bnQuickSort(arr,ARRAY_SIZE(arr));
    //    bnQuickSort_improve(arr, ARRAY_SIZE(arr));
#pragma  mark 归并
    bnMergeSort(arr, ARRAY_SIZE(arr));
#pragma  mark 基数
    //    bnBucketSort(arr, ARRAY_SIZE(arr));
    
#pragma  mark test
    //    testCharacteristics();
    //    recursionTest(0, 5);
    
}

@end

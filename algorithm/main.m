//
//  main.m
//  algorithm
//
//  Created by Berning on 2018/10/9.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "interview.h"
#import "sort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        int arr[]={0,1,2,3,4,5,6,7,8,9};
        ePrint(arr, ARRAY_SIZE(arr));
        ePrintName;
        

        shuffle(arr,ARRAY_SIZE(arr));
//        InsertionSort(arr, ARRAY_SIZE(arr));
//        shellSort(arr,ARRAY_SIZE(arr));
//        SelectSort(arr, ARRAY_SIZE(arr));
//        bubbleSort(arr,ARRAY_SIZE(arr));
        quickSort(arr, 0, ARRAY_SIZE(arr)-1);

        
        
        
        
//        testCharacteristics();
        


    }
    return 0;
}




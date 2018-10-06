//
//  common.m
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

#import "common.h"

@implementation common

void ePrint(int a[], int n ){
    
    
    for(int j= 0; j<n; j++){
        
        printf("%d ",a[j]);
    }
    printf("\n");
}

void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

@end        

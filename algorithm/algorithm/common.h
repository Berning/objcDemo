//
//  common.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

#define ePrintNameM(i)   printf("---%s_time%d\n",__func__,i);
#define ePrintName       printf("---%s\n",__func__);
#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
#define ePrintNameQuickS(i,loc)   printf("---%s_time%d---%s\n",__func__,i,loc);

#define ePrintSearchResult(result)     printf("result:%d\n",result);

#import <Foundation/Foundation.h>


@interface common : NSObject

void ePrint(int a[], int n );

void swap(int *a, int *b);


@end

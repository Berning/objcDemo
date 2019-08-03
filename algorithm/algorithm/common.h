//
//  common.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

//打印方法名及次数
#define ePrintNameM(i)   printf("---%s_time%d\n",__func__,i);

//打印方法名
#define ePrintName       printf("---%s\n",__func__);

//计算c数组长度
#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))

//打印快速排序信息
#define ePrintNameQuickS(i,loc)   printf("---%s_time%d---%s\n",__func__,i,loc);

//打印查找算法结果
#define ePrintSearchResult(result)     printf("result:%d\n",result);

#import <Foundation/Foundation.h>


@interface common : NSObject

void ePrint(int a[], int n );

void swap(int *a, int *b);


@end

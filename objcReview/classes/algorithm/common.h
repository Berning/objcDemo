//
//  common.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//
#define eLine       NSLog(@"------------------------------------");
#define ePrintf(inta,floata)     NSLog(@"%f--%ld",inta,floata);

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface common : NSObject

void ePrint(int a[], int n );

void swap(int *a, int *b);

@end

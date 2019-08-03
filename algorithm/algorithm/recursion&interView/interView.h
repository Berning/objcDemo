//
//  interView.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//
//洗牌
//开方
//递归遍历树
//过滤数组重复元素

#import <Foundation/Foundation.h>

@interface interView : NSObject

void shuffle(int *a ,int n);

//sqrt
float sqrtByBisection(float n); //二分
float sqrtByNewton(float x);    //newton
float sqrtByCarmack(float x);  //John Carmack

void testCharacteristics(void);


void filterArrayRepeatElements(int *a,int n);


@end

//
//  sqList.h
//  algorithm
//
//  Created by Berning on 2018/10/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

#ifndef SEQUENCE_LINER_LIST_H
#define SEQUENCE_LINER_LIST_H

/*
 线性表的顺序实现
 */
#define LIST_INIT_SIZE 100  //初始分配量
#define LIST_INCREMENT 10   //增量
#define LIST_TYPE int       //存储类型

#endif

typedef struct
{
    LIST_TYPE *elem;        //存储空间基址
    unsigned int length;    //当前长度
    unsigned int listSize;  //当前存储容量
}SeqLinerList;

typedef enum
{
    OK=1,
    ERROR=0,
    OVERFLOWED=-1
}Status;


NS_ASSUME_NONNULL_BEGIN

@interface sqList : NSObject

@property(class,readonly)void test;
@end

NS_ASSUME_NONNULL_END

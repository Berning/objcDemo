
//
//  sqList.m
//  algorithm
//
//  Created by Berning on 2018/10/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "sqList.h"

@implementation sqList

+(void)test
{
    SeqLinerList list;
    list.length=0;
    Status status =initSeqList(list);
    NSLog(@"\nstatus->%d\nelem->%p\nlength->%d\nlistSize->%d",status,list.elem,list.length,list.listSize);
    
//    status=reallocSeqList(list);
//    NSLog(@"\nstatus->%d\nelem->%p\nlength->%d\nlistSize->%d",status,list.elem,list.length,list.listSize);

}

/* 线性表初始化 */
Status initSeqList(SeqLinerList list)
{
    list.elem = (LIST_TYPE *)malloc(sizeof(LIST_TYPE)*LIST_INIT_SIZE);
    if (!list.elem)
    {
        return OVERFLOWED;
    }
    list.length = 10;
    list.listSize = LIST_INIT_SIZE;
    return OK;
}

/* 扩展 */
Status reallocSeqList(SeqLinerList list)
{
    list.elem = (LIST_TYPE*)realloc(list.elem, sizeof(LIST_TYPE)*(list.listSize + LIST_INCREMENT));
    if (!list.elem)
    {
        return OVERFLOWED;
    }
    list.listSize += LIST_INCREMENT;
    return OK;
}

@end

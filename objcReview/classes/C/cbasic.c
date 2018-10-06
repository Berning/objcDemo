
//
//  cbasic.c
//  Xcode8
//
//  Created by Berning on 2018/9/3.
//  Copyright © 2018年 BN. All rights reserved.
//

#include "cbasic.h"
int count1;
extern void write_extern(void);

static int count=10;        /* 全局变量 - static 是默认的 */

void func1(void)
{
    /* 'thingy' 是 'func1' 的局部变量 - 只初始化一次
     * 每次调用函数 'func1' 'thingy' 值不会被重置。
     */
    static int thingy=5;
    thingy++;
    printf(" thingy 为 %d ， count 为 %d\n", thingy, count);
}

void ctest(void)
{
    while (count--) {
        func1();
    }

}

//传值调用
void swap1(int x,int y)
{
    int temp=x;
    x=y;
    y=temp;
    
}

//引用调用
void swap2(int *x ,int *y)
{
    int temp=*x;
    *x=*y;
    *y=temp;
}

void invokeValue(void)
{
    int a=10;
    int b=30;
    printf("调用前：%d,%d\n",a,b);
    swap1(a, b);
    printf("传值swap1调用后：%d,%d\n",a,b);
    swap2(&a, &b);
    printf("引用swap2调用后：%d,%d\n",a,b);
    
}


int fibonaci(int i)
{
    if(i == 0)
    {
        return 0;
    }
    if(i == 1)
    {
        return 1;
    }
    return fibonaci(i-1) + fibonaci(i-2);
}


void cmain(void)
{
    
//    int i;
//    for (i = 0; i < 10; i++)
//    {
//        printf("%d\t\n", fibonaci(i));
//    }

//    ctest();
//    invokeValue();
    count1= 5;
    write_extern();
}

//void ctest(int a)
//{
//    printf("input:%d",a);
//}

void cinpunt(int a)
{
    printf("input:%d\n",a);

}


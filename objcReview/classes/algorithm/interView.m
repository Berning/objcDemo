
//
//  interView.m
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
// pmusic & sensetime 面试题

#import "interView.h"

#define eps 1e-7

@implementation interView

// 洗牌 
void shuffle(int *a ,int n)
{
    ePrint(a, n);
    
    for (int i=n-1; i>=1; i--) {
        
        swap(&a[i], &a[arc4random_uniform(i)]);
        
    }
    ePrint(a, n);
    eLine
}


int  squareSum(int n)
{
    int flags=0;
    int x=n;
    
    while (x!=0) {
        flags++;
        
        x-=(int)sqrt(x)*(int)sqrt(x);
    }
    
    
    return flags;
}

int  squareMin(int n)
{
    int flags=0;
    
//    int a=(int)sqrt(n);
    
//    if(n==0)
//        return 1;
//    else if
//    {
//        while (a>0) {
//            
//        }
//        
//    
//    }
//        
    
    
    
    return  flags;
}


//开方的三种算法

//John Carmack
//InvSqrt
float sqrtByCarmack(float x)
{
    float xhalf = 0.5f*x;
    int i = *(int*)&x; // get bits for floating VALUE
    i = 0x5f375a86- (i>>1); // gives initial guess y0
    x = *(float*)&i; // convert bits BACK to float
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    
    return 1/x;
}

float sqrtByNewton(float x)
{
    float val = x;//◊Ó÷’
    float last;//±£¥Ê…œ“ª∏ˆº∆À„µƒ÷µ
    do
    {
        last = val;
        val =(val + x/val) / 2;
    }while(fabs(val-last) > eps);
    return val;
}

//二分法
float sqrtByBisection(float n) //”√∂˛∑÷∑®
{
    if(n<0) //–°”⁄0µƒ∞¥’’ƒ„–Ë“™µƒ¥¶¿Ì
        return n;
    float mid,last;
    float low,up;
    low=0,up=n;
    mid=(low+up)/2;
    do
    {
        if(mid*mid>n)
            up=mid;
        else
            low=mid;
        last=mid;
        mid=(up+low)/2; 
    }while(fabs(mid-last) > eps);//æ´∂»øÿ÷∆
    return mid; 
}

void testCharacteristics()
{
    int loopCount=10000;
    float a=0,b=0 ,c=0,d=0;
    
    clock_t start1=clock();
    for (int i=0; i<loopCount; i++)
        a=sqrtByNewton(99);
    clock_t end1=clock();
    clock_t intervalNewton=end1-start1;
    
    clock_t start2=clock();
    for (int i=0; i<loopCount; i++)
        b=sqrtByBisection(99);
    clock_t end2=clock();
    clock_t intervalBisection=end2-start2;
    
    clock_t start3=clock();
    for (int i=0; i<loopCount; i++)
        c=sqrtByCarmack(99);
    clock_t end3=clock();
    clock_t intervalCarmack=end3-start3;
    
    clock_t start4=clock();
    for (int i=0; i<loopCount; i++)
        d=sqrtf(99);
    clock_t end4=clock();
    clock_t intervalSqrt=end4-start4;
    ePrintf(a,intervalNewton)
    ePrintf(b,intervalBisection)
    ePrintf(c,intervalCarmack)
    ePrintf(d,intervalSqrt)

}

//360面试
-(void)printViews:(UIView *)view
{
    //      NSArray *viewArray=[view subviews];
    for (UIView *childView in [view subviews]) {
        NSLog(@"%@",childView);
        if ([[childView subviews] count]!=0) {
            [self printViews:childView];
        }
    }
}


@end

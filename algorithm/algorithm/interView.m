
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
    for (int i=n-1; i>=1; i--) {
        
        swap(&a[i], &a[arc4random_uniform(i)]);
        
    }
    
    ePrint(a, n);
    ePrintName

}

//开方的三种算法

//John Carmack
//InvSqrt
float sqrtByCarmack(float x)
{
    float xhalf = 0.5f*x;
    int i = *(int*)&x; // get bits for floating VALUE
    printf("i:%d\n",i);
    i = 0x5f375a86- (i>>1); // gives initial guess y0
    x = *(float*)&i; // convert bits BACK to float
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    
    return 1/x;
}

float sqrtByNewton(float x)
{
    float val = x; //先猜想一个值，即猜想val为x
    float last;
    do
    {
        last = val;
        val =(val + x/val) / 2;
    }while(fabs(val-last) > eps);
    return val;
}

//二分法
float sqrtByBisection(float n) {
    if(n<0)
        return n;
    float mid,last;
    float low,high;
    (void)(low=0),high=n;
    mid=(low+high)/2;
    do
    {
        if(mid*mid>n)
            high=mid;
        else
            low=mid;
        last=mid;
        mid=(high+low)/2;
    }while(fabs(mid-last) > eps);
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
   
    printf("%f--%ld---Newton\n",a,intervalNewton);
    printf("%f--%ld---Bisection\n",b,intervalBisection);
    printf("%f--%ld---Carmack\n",c,intervalCarmack);
    printf("%f--%ld---Sqrt\n",d,intervalSqrt);


}

//360面试
//-(void)printViews:(UIView *)view
//{
//    //      NSArray *viewArray=[view subviews];
//    for (UIView *childView in [view subviews]) {
//        NSLog(@"%@",childView);
//        if ([[childView subviews] count]!=0) {
//            [self printViews:childView];
//        }
//    }
//}


@end

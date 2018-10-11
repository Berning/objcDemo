//
//  interView.h
//  algorithm
//
//  Created by uBerning on 16/12/29.
//  Copyright © 2016年 360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface interView : NSObject

void shuffle(int *a ,int n);

int squareSum(int n);

int  squareMin(int n);

//sqrt
float sqrtByBisection(float n); //二分
float sqrtByNewton(float x);    //newton
float sqrtByCarmack(float x);  //John Carmack

void testCharacteristics(void);


@end

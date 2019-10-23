//
//  BNPercentageCircle.m
//  UI
//
//  Created by Berning on 2018/12/19.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNPercentageCircle.h"

@implementation BNPercentageCircle

-(void)setPercent:(CGFloat)percent
{
    _percent=percent;
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    
    CGFloat centerX=rect.size.width/2;
    CGFloat centerY=rect.size.height/2;
    CGFloat innerRadius=rect.size.width/2-rect.size.width*0.18;
    CGFloat outterRadius=rect.size.width/2-rect.size.width*0.1;
    
    
    CGContextSetLineWidth(ctx, 15);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    [[UIColor redColor] set];
    
    CGContextAddArc(ctx, centerX, centerY, outterRadius,M_PI_2+M_PI_4,M_PI_2+M_PI_4+self.percent*M_PI*2, 0);
    
    

//        CGContextAddArc(ctx, centerX, centerY, outterRadius,  M_PI_2+M_PI_4,M_PI_4 , 0);
//
//    CGContextClosePath(ctx);
//    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
//
    CGContextStrokePath(ctx);
    

    
}



@end

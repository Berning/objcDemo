//
//  BNCloseView.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNCloseView.h"
#define sideLen ckNavBarHeight

@implementation BNCloseView

+ (instancetype)closeView
{
    return [[self alloc] initWithFrame:CGRectMake(10, kApplictionStatusBarHeight, sideLen, sideLen)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2);
    CGFloat padding=15;
    CGContextMoveToPoint(ctx, padding, padding);
    CGContextAddLineToPoint(ctx, rect.size.width-padding, rect.size.height-padding);
    
    CGContextMoveToPoint(ctx, padding, rect.size.height-padding);
    CGContextAddLineToPoint(ctx, rect.size.width-padding, padding);
    
    CGContextStrokePath(ctx);
    
}

- (void)addTarget:(id)target action:(SEL)action
{

    UITapGestureRecognizer *recongnizer=[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recongnizer];
}

@end

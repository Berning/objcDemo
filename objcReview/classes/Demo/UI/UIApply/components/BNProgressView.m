
//
//  BNProgressView.m
//  Xcode8
//
//  Created by uBerning on 2017/3/24.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNProgressView.h"

@implementation BNProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        self.renderColor=[UIColor greenColor];
    }
    return self;
}
- (void)setPercentage:(CGFloat)percentage
{
    _percentage = percentage;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.renderColor set];
    UIRectFill(CGRectMake(0, 0, self.percentage * rect.size.width, rect.size.height));
}

@end

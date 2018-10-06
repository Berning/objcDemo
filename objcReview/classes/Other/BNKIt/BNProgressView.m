
//
//  BNProgressView.m
//  Xcode8
//
//  Created by uBerning on 2017/3/24.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNProgressView.h"

@implementation BNProgressView

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] set];
    UIRectFill(CGRectMake(0, 0, self.progress * rect.size.width, rect.size.height));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

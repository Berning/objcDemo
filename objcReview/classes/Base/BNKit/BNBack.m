//
//  BNBack.m
//  Questions
//
//  Created by Berning on 2018/12/27.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNBack.h"

@implementation BNBack

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    [self setNeedsDisplay];

}
-(void)setTitle:(NSString *)title
{
    _title=title;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //返回图标
    CGFloat ratioH=0.4;
    CGFloat ratioV=0.3;
    
    CGFloat topX=rect.size.width*ratioH;
    CGFloat topY=rect.size.height*ratioV;
    CGContextMoveToPoint(ctx, topX, topY);
    
    CGFloat midX=rect.size.width*0.25;
    CGFloat midY=rect.size.height*(1-2*ratioV)/2.0+topY;
    CGContextAddLineToPoint(ctx, midX, midY);
    
    CGFloat bottomX=topX;
    CGFloat bottomY=rect.size.height*(1-ratioV);
    CGContextAddLineToPoint(ctx, bottomX, bottomY);
    
    CGContextSetLineWidth(ctx, 2.5f);
    
    //返回文字
    CGFloat titleX=rect.size.width*(ratioH+0.15);
    CGFloat titleY=topY;
    
    
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    [attr setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
//    [attr setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [self.title drawAtPoint:CGPointMake(titleX, titleY) withAttributes:attr];
    
    CGContextStrokePath(ctx);
    
}

-(void)addTarget:(id)target action:(SEL)action
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
}
@end

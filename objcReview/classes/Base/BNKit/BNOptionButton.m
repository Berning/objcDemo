//
//  BNOptionButton.m
//  objcReview
//
//  Created by Berning on 2019/1/25.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNOptionButton.h"
#define sideLen kNavBarHeight

@implementation BNOptionButton

+ (instancetype)listView
{
    return [[self alloc]initWithFrame:CGRectMake(kMainScreenWidth-sideLen-15, kApplictionStatusBarHeight, sideLen, sideLen) ];
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
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
    NSString *str=@"...";
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    [attr setObject:[UIFont boldSystemFontOfSize:25] forKey:NSFontAttributeName];
    
    NSMutableParagraphStyle *style=[NSMutableParagraphStyle new];
    style.alignment=NSTextAlignmentCenter;
    [attr setObject:style forKey:NSParagraphStyleAttributeName];
    [str drawInRect:rect withAttributes:attr];

}

- (void)addTarget:(id)target action:(SEL)action
{
    
    UITapGestureRecognizer *recongnizer=[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recongnizer];
}

@end

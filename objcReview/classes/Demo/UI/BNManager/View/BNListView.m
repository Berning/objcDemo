//
//  BNListView.m
//  objcReview
//
//  Created by Berning on 2019/1/25.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNListView.h"
#import "BNChoiceList.h"

#define arrowX  27
#define halfArrowW 5
#define topMargin 8

@implementation BNListView

+ (instancetype)listWithData:(NSArray *)data
{
    CGFloat w=kMainScreenWidth/2*0.7;
    CGFloat x=kMainScreenWidth-w-10;
    CGFloat y=0;
    CGFloat h=data.count*cellHeight+topMargin;
    
    static BNChoiceList *choiceList=nil;
    static BNListView *listView=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        listView=[[BNListView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        choiceList=[[BNChoiceList alloc] initWithFrame:CGRectMake(0, topMargin, w,h-topMargin) data:data];
        [listView addSubview:choiceList];
    });
    listView.hidden=YES;
    return listView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
//        self.hidden=YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGFloat w=rect.size.width;
    CGFloat h=rect.size.height;
    
    [BNColor(76, 76, 76) set];
    CGContextMoveToPoint(ctx, 0, topMargin);
    
    CGContextAddLineToPoint(ctx, w-arrowX-halfArrowW, topMargin);
    CGContextAddLineToPoint(ctx, w-arrowX, 0);
    CGContextAddLineToPoint(ctx, w-arrowX+halfArrowW, topMargin);
    CGContextAddLineToPoint(ctx, w, topMargin);
    
    CGContextAddLineToPoint(ctx, w, h);
    CGContextAddLineToPoint(ctx, 0, h);
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}
@end

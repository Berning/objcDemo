//
//  BNCollectionViewCell.m
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNCollectionViewCell.h"
#import "BNItem.h"

@interface BNCollectionViewCell ()

@property(nonatomic,weak)UILabel *nameLabel;

@end

@implementation BNCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setItem:(BNItem *)item
{
    _item=item;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    
    //文字
    CGFloat ratio=0.8;
    CGFloat nameX=0;
    CGFloat nameY=rect.size.height*ratio;
    CGFloat nameW=rect.size.width;
    CGFloat nameH=rect.size.height*(1-ratio);
    
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc ] init];
    style.alignment=NSTextAlignmentCenter;
    
    NSDictionary *attr=@{NSForegroundColorAttributeName:[UIColor blackColor],
                         NSFontAttributeName:[UIFont systemFontOfSize:18.0f],
                         NSParagraphStyleAttributeName:style
                         };
    [self.item.name drawInRect:CGRectMake(nameX,nameY,nameW, nameH)     withAttributes:attr];
    
    //画图
    UIImage *image=[UIImage imageNamed:self.item.image];
    CGFloat imageX=rect.size.width*(1-ratio);
    CGFloat imageY=rect.size.height*0.1;
    CGFloat imageW=rect.size.width-2*imageX;
    CGFloat imageH=rect.size.height*ratio-2*imageY;
    [image drawInRect:CGRectMake(imageX, imageY,imageW,imageH)];
    
    
    CGContextStrokePath(ctx);
}

@end

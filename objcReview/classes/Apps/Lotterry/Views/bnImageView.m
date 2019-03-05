//
//  bnImageView.m
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnImageView.h"

@implementation bnImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UIGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMe:)];
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:ges];

    }
    return self;
}

-(void)tapMe:(bnImageView *)img
{
    _click(img);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

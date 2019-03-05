
//
//  bnLabel.m
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnLabel.h"

@implementation bnLabel
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        UIGestureRecognizer *gesLab=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLab:)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:gesLab];
    }
    return self;
}

-(void)tapLab:(bnLabel *)label
{
    _click(label);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

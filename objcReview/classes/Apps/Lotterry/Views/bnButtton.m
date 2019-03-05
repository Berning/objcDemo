//
//  bnButtton.m
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnButtton.h"

@implementation bnButtton


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)clicked:(bnButtton *)btn
{
    _click(btn);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

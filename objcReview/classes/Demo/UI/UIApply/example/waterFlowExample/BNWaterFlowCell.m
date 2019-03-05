//
//  BNWaterFlowCell.m
//  UI
//
//  Created by Berning on 2018/12/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNWaterFlowCell.h"
#import "BNWaterflowView.h"
// 颜色
#define BNColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BNColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 随机色
#define BNRandomColor BNColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@implementation BNWaterFlowCell

+ (instancetype)cellWithWaterflowView:(BNWaterflowView *)waterflowView
{
    static NSString *ID = @"BNWaterFlowCell";
    BNWaterFlowCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BNWaterFlowCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=BNRandomColor;
    }
    return self;
}


@end

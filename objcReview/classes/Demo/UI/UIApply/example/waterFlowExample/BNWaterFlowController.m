//
//  BNWaterFlowController.m
//  UI
//
//  Created by Berning on 2018/12/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNWaterFlowController.h"
#import "BNWaterFlowCell.h"
#import "BNWaterflowView.h"

@interface BNWaterFlowController ()<BNWaterflowViewDelegate,BNWaterflowViewDataSource>

@property(nonatomic,weak)BNWaterflowView *waterflowView;

@end

@implementation BNWaterFlowController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    // 1.瀑布流控件
    BNWaterflowView *waterflowView = [[BNWaterflowView alloc] init];
    //    waterflowView.backgroundColor = [UIColor redColor];
    // 跟随着父控件的尺寸而自动伸缩 .横竖屏切换
    waterflowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    self.waterflowView=waterflowView;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //    NSLog(@"屏幕旋转完毕");
    [self.waterflowView reloadData];
}


#pragma mark - 数据源方法
- (NSUInteger)numberOfCellsInWaterflowView:(BNWaterflowView *)waterflowView
{
    return 100;
}

- (BNWaterflowViewCell *)waterflowView:(BNWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    BNWaterFlowCell *cell = [BNWaterFlowCell cellWithWaterflowView:waterflowView];
    
    
    return cell;
}

- (NSUInteger)numberOfColumnsInWaterflowView:(BNWaterflowView *)waterflowView
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        // 竖屏
        return 3;
    } else {
        return 5;
    }
}

-(CGFloat)waterflowView:(BNWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    return waterflowView.cellWidth*(arc4random_uniform(20)+80)/(arc4random_uniform(20)+70);
}

@end

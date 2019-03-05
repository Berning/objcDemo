//
//  BNLotteryController.m
//  Lottery
//
//  Created by uBerning on 2017/10/28.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNLotteryController.h"
#import "bnSubView.h"

@implementation BNLotteryController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [bnSubView subViewAddWithNavigationController:self.navigationController WithFrame:self.view.frame InView:self.view];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;

}


@end

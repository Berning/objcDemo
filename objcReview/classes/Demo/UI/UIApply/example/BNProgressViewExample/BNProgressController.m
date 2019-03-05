//
//  BNProgressController.m
//  UI
//
//  Created by Berning on 2018/12/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNProgressController.h"
#import "BNProgressView.h"
#import "BNPercentageCircle.h"

@interface BNProgressController ()
@property(nonatomic,weak)BNProgressView *progressView;


@end

@implementation BNProgressController

- (void)viewDidLoad
{
    [super viewDidLoad];
    BNProgressView *progressView=[[BNProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 3)];
    [self.view addSubview:progressView];
    self.progressView=progressView;
    
    UISlider *slider=[[UISlider alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height-120, self.view.frame.size.width-200, 44)];
    [self.view addSubview:slider];
    
    
    [slider addTarget:self action:@selector(sliderDragged:) forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)sliderDragged:(UISlider *)slider
{
    self.progressView.percentage=slider.value;
}
@end

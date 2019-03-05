//
//  BNViewManagerTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNViewManagerTest.h"
#import "BNListView.h"


@interface BNViewMangerTest ()

@property(nonatomic,weak)UIView *optionView;


@end

@implementation BNViewMangerTest


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubviews];
}

- (void)addSubviews
{
    [self.navigationManager.navigationBar.rightBarItem addTarget:self action:@selector(showOption)];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
    
    //bottom option
    CGFloat x=0;
    CGFloat y=self.view.height;
    CGFloat w=self.view.width;
    CGFloat h=self.view.height/3.0;
    UIView *optionView=[[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    optionView.backgroundColor=[UIColor navigationBarColor];
    [self.view addSubview:optionView];
    self.optionView=optionView;
    
    CGFloat cancelW=optionView.width;
    CGFloat cancelH=50;
    CGFloat cancelX=0;
    CGFloat cancelY=optionView.height-cancelH;

    UIButton *cancel=[[UIButton alloc] initWithFrame:CGRectMake(cancelX, cancelY,cancelW, cancelH)];
    [optionView addSubview:cancel];
    cancel.backgroundColor=[UIColor whiteColor];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showOption
{
    [UIView animateWithDuration:ckPresentDuration animations:^{

        CGRect rect=self.optionView.frame;
        rect.origin.y=self.view.height-self.optionView.height;
        self.optionView.frame=rect;
    }];
}

- (void)cancel
{
    [UIView animateWithDuration:ckPresentDuration animations:^{
        CGRect rect=self.optionView.frame;
        rect.origin.y=self.view.height;
        self.optionView.frame=rect;
    } completion:^(BOOL finished) {
//        [self.optionView removeFromSuperview];
    }];
}

@end

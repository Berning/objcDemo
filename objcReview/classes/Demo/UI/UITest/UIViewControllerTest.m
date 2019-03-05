//
//  UIViewControllerTest.m
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "UIViewControllerTest.h"
#import "BNCycleViewController.h"


@interface UIViewControllerTest ()

@end

@implementation UIViewControllerTest

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    [self vcTest];
}

- (void)vcTest
{
    BNLog(@"self.parentViewController:%@",self.parentViewController); //BNNavigationController
    BNLog(@"self.presentedViewController:%@",self.presentedViewController); //null here. presentViewController <BNNavigationController>
    BNLog(@"self.presentingViewController:%@",self.presentingViewController); //null here dismissViewController <BNTabBarController>
    

}

- (void)setupSubViews
{
    UIButton *btn=[[UIButton alloc ] initWithFrame:CGRectMake(20, 114, 60, 40)];
    btn.backgroundColor=[UIColor blueColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClicked
{
    BNNavigationController *nav=[[BNNavigationController alloc] initWithRootViewController:[BNCycleViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{

    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    
    BNLog(@"self.presentedViewController:%@",self.presentedViewController); //？？？？    

}
@end

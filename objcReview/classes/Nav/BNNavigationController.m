//
//  BNNavigationController.m
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNNavigationController.h"

@interface BNNavigationController ()<UIGestureRecognizerDelegate>

@property(nullable, nonatomic,strong,readwrite) UIGestureRecognizer *fullInteractivePopGestureRecognizer;

@end

@implementation BNNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIView *view = self.interactivePopGestureRecognizer.view;
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    self.fullInteractivePopGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    self.fullInteractivePopGestureRecognizer.delaysTouchesBegan = YES;
    self.fullInteractivePopGestureRecognizer.delegate = self;
    [view addGestureRecognizer:self.fullInteractivePopGestureRecognizer];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 左滑时可能与UITableView左滑删除手势产生冲突
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0)
    {
        return NO;
    }
    
    // 跟视图控制器不响应手势
    return ([self.viewControllers count] == 1) ? NO : YES;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end

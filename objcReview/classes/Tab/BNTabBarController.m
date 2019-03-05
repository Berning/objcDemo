//
//  BNTabBarController.m
//  objcReview
//
//  Created by Berning on 2019/1/1.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNTabBarController.h"
#import "BNDemoController.h"
#import "BNQuesController.h"
#import "BNBlogController.h"
#import "BNAppsController.h"

@interface BNTabBarController ()

@end

@implementation BNTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildControllers];

}


- (void)setupChildControllers
{
    BNDemoController *demo=[BNDemoController new];
    [self addChildController:demo title:@"呆萌" image:@"demo" selectedImage:@"demo"];
    
    BNQuesController *ques=[BNQuesController new];
    [self addChildController:ques title:@"问题" image:@"ques" selectedImage:@"ques"];
    
    BNBlogController *blog=[[BNBlogController alloc] init];
    [self addChildController:blog title:@"博客" image:@"blog" selectedImage:@"blog"];

    BNAppsController *app=[BNAppsController new];
    [self addChildController:app title:@"应用" image:@"app" selectedImage:@"app"];

}

- (void)addChildController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    [self addChildViewController:childVC];

    [self addChildViewController:[[BNNavigationController alloc]initWithRootViewController:childVC]];

    self.tabBar.tintColor=[UIColor blackColor];
    self.tabBar.unselectedItemTintColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];

    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
}

@end

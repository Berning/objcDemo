//
//  BNQuesController.m
//  objcReview
//
//  Created by Berning on 2019/1/1.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNQuesController.h"
#import "BNQuestionsInputViewController.h"
#import "BNQuestionViewController.h"
#import "BNViewControllersSwitchComponent.h"


@interface BNQuesController ()
@end


@implementation BNQuesController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
}


- (void)initialSetup
{
    
    BNQuestionsInputViewController *inputVC=[[BNQuestionsInputViewController alloc] init];
    inputVC.title=@"新的问题";
    
//    UINavigationController *inputNav=[[UINavigationController alloc] initWithRootViewController:inputVC];
    
    [self addChildViewController:inputVC];
    
    
    BNQuestionViewController *questionVC=[[BNQuestionViewController alloc] init];
    questionVC.title=@"我的问题";
    
//    UINavigationController *questionNav=[[UINavigationController alloc] initWithRootViewController:questionVC];
    [self addChildViewController:questionVC];
    
    
    [BNViewControllersSwitchComponent controllersSwitchOnController:self superViewType:BNSuperViewTypeOnTitleView];

}



@end

//
//  BNQuestionViewController.m
//  Questions
//
//  Created by Berning on 2018/12/18.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNQuestionViewController.h"
#import "BNQuestionsTableViewController.h"
#import "BNAnswerViewController.h"
#import "BNMenu.h"


@interface BNQuestionViewController ()

@end

@implementation BNQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BNQuestionsTableViewController *questionVC=[[BNQuestionsTableViewController alloc] init];
    questionVC.title=@"历史问题";
    
    UINavigationController *questionNav=[[UINavigationController alloc] initWithRootViewController:questionVC];
    [self addChildViewController:questionVC];
    
    
    BNQuestionsTableViewController *answerVC=[[BNQuestionsTableViewController alloc] init];
    answerVC.title=@"问题答案";
    
    UINavigationController *answerNav=[[UINavigationController alloc] initWithRootViewController:answerVC];
    [self addChildViewController:answerVC];

    
//    [BNViewControllersSwitchComponent controllersSwitchOnController:self superViewType:BNSuperViewTypeOnView];
}


@end

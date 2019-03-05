
//
//  BNCycleViewController.m
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNCycleViewController.h"

@interface BNCycleViewController ()

@end

@implementation BNCycleViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"initWithNibName");
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder");
    return [super initWithCoder:aDecoder];
}

-(void)loadView
{
    [super loadView];
    NSLog(@"loadView");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"viewCycle";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    NSLog(@"viewDidLoad");

}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:completion];
    BNLog(@"self.presentingViewController:%@",self.presentingViewController); //？？？？

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}


-(void)dealloc
{
    NSLog(@"dealloc");
    
}


@end

//
//  BNVcCycleViewController.m
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNVcCycleViewController.h"
#import "BNViewController.h"


@interface BNVcCycleViewController ()

@end

@implementation BNVcCycleViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad");
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"--%@",self.view.backgroundColor);
    //subViews
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 60, 40)];
    lb.backgroundColor=[UIColor yellowColor];
    lb.text=@"label";
    [self.view addSubview:lb];
    
    
    UIButton *btn=[[UIButton alloc ] initWithFrame:CGRectMake(20, 114, 60, 40)];
    btn.backgroundColor=[UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    
    //    NSRunLoop
    //    CFRunLoopRef
    //    CFRunLoopTimerRef
    //    CFRunLoopSourceRef
    //    CFRunLoopMode
    //    CFRunLoopObserverRef
    
    
    //    runLoopMode
    //    NSDefaultRunLoopMode
    //    UITrackingRunLoopMode
    //    NSRunLoopCommonModes
    
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


-(void)btnClicked:(UIButton *)btn
{
    BNViewController *vc=[BNViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    UIButton *button=[[UIButton alloc ] initWithFrame:CGRectMake(20, 114, 60, 40)];
    button.backgroundColor=[UIColor redColor];
    button.titleLabel.text=@"点我啊";
    [vc.view addSubview:button];
    }


@end

//
//  BNWebViewController.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNWebViewController.h"
#import <WebKit/WebKit.h>
#import "BNQuestionsTableViewController.h"
@interface BNWebViewController ()<BNQuestionsTableViewControllerDelegate>

@end

@implementation BNWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor lightGrayColor];
//    BNQuestionsTableViewController *questionVC=[BNQuestionsTableViewController new];
//    questionVC.delegate=self;
    
}


#pragma mark - QuestionsTableViewController Delegate

-(void)questionsTableViewCellLoadString:(NSString *)string
{
    [self loadString:string];
}

-(void)loadString:(NSString *)string
{
    WKWebView *webView=[[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com?wd=%@",[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求加载网页
    [webView loadRequest:request];

}

@end

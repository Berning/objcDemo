//
//  BNHtmlDetailController.m
//  objcReview
//
//  Created by Berning on 2019/2/6.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNHtmlDetailController.h"
#import <WebKit/WebKit.h>

@interface BNHtmlDetailController ()

@end

@implementation BNHtmlDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *file=[self.title stringByAppendingString:@".html"];

    if ( ![[NSBundle mainBundle] URLForResource:file withExtension:nil]) {
//        BNLog(@"no file:%@",file);
        file=[self.title stringByAppendingString:@".htm"];
    }
    

    WKWebView *webView=[[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    
    // 创建URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求加载网页
    [webView loadRequest:request];
//    NSLog(@"%@=====%@",[NSBundle mainBundle],[NSBundle mainBundle].resourceURL);
    
}



@end

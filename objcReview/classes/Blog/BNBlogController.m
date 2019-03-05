//
//  BNBlogController.m
//  objcReview
//
//  Created by Berning on 2019/1/1.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNBlogController.h"
#import <WebKit/WebKit.h>
#import "BNProgressView.h"
#import "BNBackButton.h"
#define urlStr @"http://www.runoob.com"

@interface BNBlogController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,weak)WKWebView *webView;
@property(nonatomic,weak)BNBackButton *back;
@property(nonatomic,weak)BNProgressView *progress;
@property(nonatomic,weak)UILabel *titleView;


@end

@implementation BNBlogController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runnoob];
}


- (void)runnoob
{
    self.navigationController.navigationBar.hidden=YES;
    
    CGFloat backX=0;
    CGFloat backY=20;
    CGFloat backW=66;
    CGFloat backH=44;
    
    BNBackButton *back=[[BNBackButton alloc ] initWithFrame:CGRectMake(backX, backY, backW, backH)];
    back.title=@"返回";
    [back addTarget:self action:@selector(back:)];
    [self.view addSubview:back];
    self.back=back;
    back.hidden=YES;
    
    CGFloat titleW=self.view.frame.size.width-2*backW;
    CGFloat titleX=self.view.frame.size.width-titleW-backW;
    CGFloat titleY=backY;
    CGFloat titleH=backH;
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    title.textAlignment=NSTextAlignmentCenter;
    [title setTextColor:[UIColor blackColor]];
    [self.view addSubview:title];
    self.titleView=title;
    
    
    CGFloat progressX=0;
    CGFloat progressY=CGRectGetMaxY(back.frame);
    CGFloat progressW=self.view.frame.size.width;
    CGFloat progressH=3;
    BNProgressView *progress=[[BNProgressView alloc] initWithFrame:CGRectMake(progressX, progressY, progressW, progressH)];
    progress.renderColor=[UIColor colorWithRed:148/255.0 green:185/255.0 blue:131/255.0 alpha:1.0];
    [self.view addSubview:progress];
    self.progress=progress;
    
    CGFloat webViewX=0;
    CGFloat webViewY=CGRectGetMaxY(progress.frame);
    CGFloat webViewW=self.view.frame.size.width;
    CGFloat webViewH=self.view.frame.size.height-webViewY;
    WKWebView *webView=[[WKWebView alloc]initWithFrame:CGRectMake(webViewX, webViewY,webViewW,webViewH)];
    [self.view addSubview:webView];
    self.webView=webView;
    webView.navigationDelegate=self;
    webView.UIDelegate=self;
    webView.allowsBackForwardNavigationGestures=YES;
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求加载网页
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    //    NSLog(@"estimatedProgress:%f",self.webView.estimatedProgress);
    //    NSLog(@"cangoback:%d",self.webView.canGoBack);
    
    [UIView animateWithDuration:0.5f animations:^{
        (self.webView.canGoBack)? (self.back.hidden=NO):(self.back.hidden=YES);
        self.progress.percentage=self.webView.estimatedProgress;
        
    }];
    
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    
}

- (void)back:(UIButton *)back
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark --UI Delegate
#pragma mark --naviDelegate

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation");
    
    self.progress.hidden=NO;
    
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
    [self setTitleViewTitle];
    NSLog(@"didCommitNavigation");
    
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
    self.progress.hidden=YES;
    
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
    
    self.progress.hidden=YES;
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation:%@,%@",webView.title,webView.URL);
    [self setTitleViewTitle];
    self.progress.hidden=YES;
    
}

- (void)setTitleViewTitle
{
    NSString *titleString=self.webView.backForwardList.currentItem.title;
    
    if ([titleString containsString:@"-"]||[titleString containsString:@"_"]||[titleString containsString:@" "])
    {
        if ([titleString containsString:@" "])
        {
            NSRange arange=[titleString rangeOfString:@" "];
            titleString=[titleString substringWithRange:NSMakeRange(0, arange.location)];
        }
        
        if ([titleString containsString:@"-"])
        {
            NSRange arange=[titleString rangeOfString:@"-"];
            titleString=[titleString substringWithRange:NSMakeRange(0, arange.location)];
        }
        if ([titleString containsString:@"_"])
        {
            NSRange arange=[titleString rangeOfString:@"_"];
            titleString=[titleString substringWithRange:NSMakeRange(0, arange.location)];
        }
    }
    else
    {
        titleString=[titleString substringToIndex:4];
    }
    NSLog(@"titleString:%@",titleString);
    self.titleView.text=titleString;
    
}

@end

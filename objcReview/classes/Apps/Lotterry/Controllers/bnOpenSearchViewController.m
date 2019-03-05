//
//  bnOpenSearchViewController.m
//  Lottery
//
//  Created by Berning on 2018/12/2.
//  Copyright © 2018年 BN. All rights reserved.
//



#import "bnOpenSearchViewController.h"
#import <WebKit/WebKit.h>
#import "BNProgressView.h"
@interface bnOpenSearchViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,weak)WKWebView *webView;
@property(nonatomic,weak)UIButton *back;
@property(nonatomic,weak)BNProgressView *progress;
@property(nonatomic,weak)UILabel *titleView;

@end

@implementation bnOpenSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self lottoSeach];
    
}



- (void)lottoSeach
{
    self.navigationController.navigationBar.hidden=YES;
    
    CGFloat backX=0;
    CGFloat backY=20;
    CGFloat backW=66;
    CGFloat backH=44;
    
    UIButton *back=[[UIButton alloc ] initWithFrame:CGRectMake(backX, backY, backW, backH)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:back];
    self.back=back;
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    back.hidden=YES;
    
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
    progress.renderColor=[UIColor redColor];
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
    NSURL *url = [NSURL URLWithString:@"http://sports.sina.com.cn/l/kaijiang/"];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求加载网页
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    //    NSLog(@"estimatedProgress:%f",self.webView.estimatedProgress);
    //    NSLog(@"cangoback:%d",self.webView.canGoBack);
    
    [UIView animateWithDuration:0.5f animations:^{
//        (self.webView.canGoBack)? (self.back.hidden=NO):(self.back.hidden=YES);
        
        self.progress.percentage=self.webView.estimatedProgress;
        
    }];
    
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    
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

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
    
    self.progress.hidden=YES;
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"webView:%@,%@",webView.title,webView.URL);
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

- (void)test
{
    NSLog(@"didFinishNavigation");
    
    NSLog(@"backItem:%@",self.webView.backForwardList.backItem.title);
    NSLog(@"currentItem:%@",self.webView.backForwardList.currentItem.title);
    NSLog(@"forwardItem:%@",self.webView.backForwardList.forwardItem.title);
    
    
    NSLog(@"backItemUrl:%@",self.webView.backForwardList.backItem.URL);
    NSLog(@"currentItemUrl:%@",self.webView.backForwardList.currentItem.URL);
    NSLog(@"forwardItemUrl:%@",self.webView.backForwardList.forwardItem.URL);
    NSLog(@"backItemInitUrl:%@",self.webView.backForwardList.backItem.initialURL);
    NSLog(@"currentItemInitUrl:%@",self.webView.backForwardList.currentItem.initialURL);
    NSLog(@"forwardItemInitUrl:%@",self.webView.backForwardList.forwardItem.initialURL);
    
    //    NSLog(@"backList:%ld",self.webView.backForwardList.backList.count);
    //    for (WKBackForwardListItem *item in self.webView.backForwardList.backList) {
    //        NSLog(@"backList:%@",item.title);
    //    }
    //
    //    NSLog(@"forwardList:%ld",self.webView.backForwardList.forwardList.count);
    //    for (WKBackForwardListItem *item in self.webView.backForwardList.forwardList) {
    //        NSLog(@"forwardList:%@",item.title);
    //    }
    
    
    
    

}


@end

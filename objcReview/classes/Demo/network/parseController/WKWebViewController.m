//
//  WKWebViewController.m
//  objcReview
//
//  Created by aBerning on 2019/9/3.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "WKWebViewController.h"

#import <WebKit/WebKit.h>

@interface WKWebViewController ()

@property (nonatomic,strong)WKWebView *webView;

@end

@implementation WKWebViewController

- (WKWebView *)webView
{
    if(!_webView)
    {
        _webView=[[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return  _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self loadRequstBase];
    
}

- (void)loadRequstBase
{
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    
    NSHTTPURLResponse *response=nil;
    NSError *error=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error ];
    
    
    NSLog(@"data:%@",data);
    NSLog(@"MIMEType:%@",response.MIMEType);
    NSLog(@"statusCode:%ld",(long)response.statusCode);
    NSLog(@"error:%ld",(long)error.code);
    
    [self loadRequest:request];
//    [self loadString:@"<p>hello</p>" baseUrl:nil];
//    [self loadFileUrl:(NSURL *) allowingReadAccessToURL:(NSURL *)]
//    [self loadData:data MIMEType:response.MIMEType characterEncodingName:@"utf-8" baseURL:nil];
}


- (void)loadRequest:(NSURLRequest *)request
{
    [self.webView loadRequest:request];
}

- (void)loadString:(NSString *)htmlString baseUrl:(NSURL *)baseUrl
{
    [self.webView loadHTMLString:htmlString baseURL:nil];

}
- (void)loadFileUrl:(NSURL *)url allowingReadAccessToURL:(NSURL *)readAccessURL
{
    if (iOS9) {
        [self.webView loadFileURL:url allowingReadAccessToURL:readAccessURL];
    }
}
- (void)loadData:(NSData *)data MIMEType:( NSString *)MIMEType characterEncodingName:( NSString *)encodingName baseURL:( NSURL *)baseUrl
{
    
    if (iOS9) {
        
        NSString *nullStr=@"";
        NSLog(@"nullStr:%p-%@",nullStr,nullStr);
        NSLog(@"NULL:%p-%@",NULL,NULL);
        NSLog(@"nil:%p-%@",nil,nil);
        NSLog(@"Nil:%p-%@",Nil,Nil);
        NSLog(@"NSNull:%p---%@",[NSNull null],[NSNull null]);

        NSLog(@"iOS%@",[NSString stringWithDeviceSystemVersion]);
        [self.webView loadData:data MIMEType:MIMEType characterEncodingName:encodingName baseURL:baseUrl];
    }
}

@end

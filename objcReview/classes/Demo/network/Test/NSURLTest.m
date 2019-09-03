//
//  NSURLTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "NSURLTest.h"

@implementation NSURLTest

+ (void)test
{
    NSURL *url=[NSURL URLWithString:@"https://www.baidu.com/"];
    
    NSURL *url1=[NSURL URLWithString:@"https://www.baidu.com/v1?name=wbn&age=20"];
    
    NSLog(@"url:%@-----%@",url,url1);
    NSLog(@"host :%@-----%@",url.host,url1.host);
    NSLog(@"port:%@-----%@",url.port,url1.port);
    NSLog(@"user:%@-----%@",url.user,url1.user);
    NSLog(@"password:%@-----%@",url.password,url1.password);
    NSLog(@"path:%@-----%@",url.path,url1.path);
    NSLog(@"fragment:%@-----%@",url.fragment,url1.fragment);
    NSLog(@"password:%@-----%@",url.password,url1.password);
    NSLog(@"parameterString:%@-----%@",url.parameterString,url1.parameterString);
    NSLog(@"relativePath:%@-----%@",url.relativePath,url1.relativePath);
    NSLog(@"query:%@-----%@",url.query,url1.query);
    

}


@end

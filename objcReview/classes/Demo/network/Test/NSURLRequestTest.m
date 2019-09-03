//
//  NSURLRequestTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "NSURLRequestTest.h"

@implementation NSURLRequestTest

+ (void)test
{
    NSDictionary *dic=@{
                        @"Q":@"qqqqq",
                        @"T":@"ttttt",
                        @"data":@{
                                
                                @"2019-08-28":@{
                                        @"step":@11110,
                                        @"sleep":@7,
                                        @"sit":@3
                                        },
                                
                                @"2019-08-29":@{
                                        @"step":@20000,
                                        @"sleep":@6.5,
                                        @"sit":@2
                                        }
                                }
                        };
    
    
    NSMutableDictionary *mutableDic=[dic mutableCopy];
    [mutableDic setValue:@"bn" forKey:@"w"];
    dic=mutableDic;
    NSLog(@"dic:%@",dic);
    
    
    NSURL *url=[NSURL URLWithString:@"https://www.baidu.com/"];
    
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    request.URL=url;
    request.HTTPMethod=@"post";
    request.HTTPBody=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    [request setValue:@"setValue" forHTTPHeaderField:@"setKey"];
    [request addValue:@"addValue" forHTTPHeaderField:@"addKey"];
    
    NSLog(@"request:%@",request);
    NSLog(@"allHTTPHeaderFields:%@",request.allHTTPHeaderFields);
    NSLog(@"URL:%@",request.URL);
    NSLog(@"HTTPMethod:%@",request.HTTPMethod);
    NSLog(@"HTTPBody:%@",request.HTTPBody);
    NSLog(@"mainDocumentURL:%@",request.mainDocumentURL);
    NSLog(@"allowsCellularAccess:%d",request.allowsCellularAccess);
    NSLog(@"networkServiceType:%lu",request.networkServiceType);
    NSLog(@"timeoutInterval:%f",request.timeoutInterval);
    

}

@end

//
//  NSURLResponseTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "NSURLResponseTest.h"

@implementation NSURLResponseTest


+ (void)test
{
//    NSURL *url=[NSURL URLWithString:@"http://berning.wang/objc/login"];
    NSURL *url=[NSURL URLWithString:@"http://localhost/objc/login"];

    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSLog(@"timeoutInterval:%f",request.timeoutInterval); //default is 60s

    
    request.HTTPMethod=@"POST";
    NSString *str=[NSString stringWithFormat:@"username=lisi&password=li"];
    request.HTTPBody=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
     {
         NSHTTPURLResponse *res=[response copy];
         NSLog(@"response:%@",res);
         
         NSLog(@"URL:%@",res.URL);
         NSLog(@"MIMEType:%@",res.MIMEType);
         NSLog(@"expectedContentLength:%lld",res.expectedContentLength);
         NSLog(@"textEncodingName:%@",res.textEncodingName);
         NSLog(@"suggestedFilename:%@",res.suggestedFilename);
         
         NSLog(@"statusCode:%ld",(long)res.statusCode);
         NSLog(@"allHeaderFields:%@",res.allHeaderFields);
         
         if (!connectionError)
         {
             NSError *error=nil;
             
             if (data)
             {
                 NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                 if (json)
                 {
                     NSLog(@"json:%@",json);
                     
                 }
                 else
                 {
                     NSLog(@"error:%@",error);
                 }
             }
             
         }
         else
         {
             NSLog(@"connectionError:%@",connectionError);
         }
         
     }];
    
    
}


@end

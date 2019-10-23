//
//  NSURLConnectionTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "NSURLConnectionTest.h"

@implementation NSURLConnectionTest


+ (void)test
{
    
//    [self testGET];
    [self testPost];
}

+ (void)testPost
{
//    NSURL *url=[NSURL URLWithString:@"http://berning.wang/objc/login"];
    NSURL *url=[NSURL URLWithString:@"http://localhost/objc/login"];

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    NSString *str=[NSString stringWithFormat:@"username=lisi&password=li"];
    request.HTTPBody=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
     {
         
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

+ (void)testGET
{
    NSURL *url=[NSURL URLWithString:@"http://berning.wang/objc/login?username=lisi&password=li"];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
    {
        if (!connectionError)
        {
            NSError *error=nil;
            
            if (data)
            {
                NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (!error)
                {
                    NSLog(@"json:%@",json);
                    
                }
                else
                {
                    NSLog(@"error:%@",error);
                }
            }
            else
            {
                NSLog(@"connectionError:%@",connectionError);
            }

        }
        else
        {
            NSLog(@"connectionError:%@",connectionError);
        }
        
    }];
}

@end

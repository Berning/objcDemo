//
//  AFNetworkingTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "AFNetworkingTest.h"

@implementation AFNetworkingTest

+ (void)test
{


    NSURL *url=[NSURL URLWithString:@"https://www.baidu.com/"];

    
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
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];

    [manager POST:@"https://www.baidu.com" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSLog(@"constructingBodyWithBlock");
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
    
    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    [manager POST:@"https:www.baidu.com" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSLog(@"success:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//    }];
    
//    [manager GET:@"https://www.baidu.com" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSLog(@"success:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"domain:%@ code:%ld",error.domain,(long)error.code);
//
//    }];
    

}

@end

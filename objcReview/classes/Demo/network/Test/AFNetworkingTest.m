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
    [self testNSUrlConnection];
//    [self testNSUrlSession];
}

+ (void)testNSUrlSession
{
        NSDictionary *dic=@{
                            @"username":@"lisi",
                            @"password":@"li"
    
                            };
    
        NSString  *urlString=@"http:/localhost/objc/login";
    
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:urlString parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",task.response);
        NSLog(@"responseObject:%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    

}

+ (void)testNSUrlConnection
{
    
        NSDictionary *dict=@{
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
    

    [dict mutableCopy];
    
    //文件名要么不写后缀。要么写对。例如：html写成htm，服务器会返回404
    
    NSDictionary *dic=@{
                        @"username":@"lisi",
                        @"password":@"li"

                        };
    
//    NSString  *urlString=@"http://localhost/objc/login";
    NSString  *urlString=@"http://121.40.171.11/objc/login.php";

    //        "Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips PHP/7.1.32 mod_perl/2.0.10 Perl/v5.16.3"
//    "Apache/2.4.34 (Unix) PHP/7.1.23"

    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //请求html等文件
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSLog(@"request:%@",operation.request);
//        NSLog(@"response:%@",operation.response);
//        NSLog(@"responseobject:%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"request:%@",operation.request);
//
//        NSLog(@"error:%@",error);
//    }];
    
    
    //    [manager POST:@"https://www.baidu.com" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        NSLog(@"constructingBodyWithBlock");
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"success");
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"failure");
    //    }];
    
    
        [manager GET:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"request:%@",operation.request);
            NSLog(@"timeoutInterval:%f",operation.request.timeoutInterval);

            NSLog(@"response:%@",operation.response);
            
            NSLog(@"responseData:%@",operation.responseData);
            NSLog(@"responseString:%@",operation.responseString);
            
            NSLog(@"responseObject:%@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@",error);
    
        }];

}


@end

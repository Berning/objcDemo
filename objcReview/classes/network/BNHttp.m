//
//  BNHttp.m
//  Xcode8
//
//  Created by uBerning on 2017/3/17.
//  Copyright © 2017年 BN. All rights reserved.
//



#import "BNHttp.h"
#import "BNPerson.h"
#import "MJExtension.h"

@implementation BNHttp



+(void)deviceDidConnectedNetworking:(void (^)(AFNetworkReachabilityStatus))block
{
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络" );
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络不可用" );

                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                block(status);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                block(status);
                break;
            default:
                break;
        }
    }];
    [mgr startMonitoring];
}


+(id)serializationExecution:(id)obj
{
    NSError *error;
    return  [obj isKindOfClass:[NSData class]]?
    [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:&error]:[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
}

+(void)test
{
//    [self handleWithURLConnection];
    
    [self handleWithSession];
}

+(void)handleWithSession
{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    [mgr GET:@"https://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"success");

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");

    }];

}

+(void)handleWithURLConnection
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"https://wx2.sinaimg.cn/mw690/624d98e1ly1fdmcckuhkcj20en081aaf.jpg" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success:%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure:%ld--%@",error.code,error.domain);
        

    }];
    
}


@end


@implementation BNKeyValue

+(void)test
{
    BNPerson *per=[self bnKeyValues];
    NSLog(@"%@",per.mj_keyValues);
    
}

+(BNPerson *)bnKeyValues
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    dict[@"name"]=@"wbn";
    dict[@"age"]=@"20";
    dict[@"tclass"]=@"七班";
    dict[@"gf"]=@"妹子";

    BNPerson *person=[BNPerson mj_objectWithKeyValues:dict];

    return person;
}



@end




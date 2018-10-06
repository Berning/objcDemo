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

+(void)afnExetion
{
//    [self handleWithURLConnection];
    
//    [self handleWithSession];
}

+(void)handleWithSession
{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    [mgr GET:@"https://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",mgr);
        NSLog(@"success");

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");

    }];

}

+(void)handleWithURLConnection
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"https://wx2.sinaimg.cn/crop.0.0.1919.1079.1000/6e53d84fly1fdt4l2wks0j21hc0u07ke.jpg" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",mgr);
        NSLog(@"success");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure:%@",mgr);
        NSLog(@"failure");

    }];
    
    
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"unkown");
                break;
            case 0:
                NSLog(@"not able");
                break;
            case 1:
                NSLog(@"wwan");
                break;
            case 2:
                NSLog(@"WIFI");
                break;
                
                
            default:
                break;
        }
    }];
    
    [manager startMonitoring];


}


@end


@implementation BNKeyValue


+(BNPerson *)keyValues
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    dict[@"name"]=@"wbn";
    dict[@"age"]=@"20";
    dict[@"tclass"]=@"七班";
    dict[@"gf"]=@"妹子";

    BNPerson *person=[BNPerson mj_objectWithKeyValues:dict];

    return person;
}


+(id)objectWithKeyValues
{
    BNPerson *person=[BNPerson person];
    person.name=@"berning";
    person.age=110;
    person.tclass=@"毕业";
    person.weight=@"100";
    
    
    return  person.mj_keyValues;
}

@end




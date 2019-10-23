//
//  BNDownLoadTest.m
//  objcReview
//
//  Created by aBerning on 2019/9/30.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNDownLoadTest.h"

#define kDowloadUrlStringPromo @"http://121.40.171.11/sources/promo.mp4"
#define kDowloadUrlStringLove @"http://121.40.171.11/sources/love.mp4"
#define kDowloadUrlStringWife @"http://121.40.171.11/sources/wife.mp4"

//我的带宽2Mb/s=2^8KB/s=2^18KB/s ,则每次下载2^18B
#define kBytesOfOnce 262144

@interface BNDownLoadTest ()

@property(nonatomic,strong)NSString *cacheDirectory;

@property(nonatomic,strong)NSURL *videoUrl;

@end


@implementation BNDownLoadTest

#pragma mark - lazy

- (void)setCacheDirectory:(NSString *)cacheDirectory
{
    NSString *cache=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *videosPath=[cache stringByAppendingPathComponent:[NSString MD5WithString:@"User_Videos"]];

    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isDirectory=NO;
    BOOL isExisted=[fileManager fileExistsAtPath:videosPath isDirectory:&isDirectory];
//    NSLog(@"exist:%d--%d",isExisted,isDirectory);
    
    if (!isExisted)
    {
        [fileManager createDirectoryAtPath:videosPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    _cacheDirectory=[videosPath stringByAppendingPathComponent:[NSString MD5WithString:cacheDirectory]];
}

#pragma mark - Test Interface

+ (void)test
{
    BNDownLoadTest *downloader=[[self alloc] init];
    [downloader downloadFileWithUrl:kDowloadUrlStringLove completion:^(NSString * _Nonnull urlString) {
        NSLog(@"urlString:%@",urlString);
        NSLog(@"url:%@",[NSURL URLWithString:urlString]);
    }];
}

+(void)downloadFileWithUrl:(NSString *)urlString completion:(void (^)(NSString * _Nonnull))completion
{
    BNDownLoadTest *downloader=[[self alloc] init];
    [downloader downloadFileWithUrl:urlString completion:completion];
}

#pragma mark - File Size & Request

- (NSMutableURLRequest *)mutableRequestWithUrlString:(NSString *)urlString
{
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *mutableRequest=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0f];
    return mutableRequest;
}

- (long long)remoteFileSizeWirhUrlSring:(NSString *)urlString
{
    NSMutableURLRequest *mutableRequest=[self mutableRequestWithUrlString:urlString];
    mutableRequest.HTTPMethod=@"HEAD";
    NSURLResponse *response=nil;
    [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:&response error:NULL];
    NSLog(@"%lld",response.expectedContentLength);
    return response.expectedContentLength;
}

#pragma mark - Download

- (void)downloadFileWithUrl:(NSString *)urlString completion:(void (^)(NSString * urlString))completion
{
    //1.创建文件
    self.cacheDirectory=urlString;

    //2.判断是否有本地缓存
    long long fileSize=[self remoteFileSizeWirhUrlSring:urlString];
    long long localFileSize=[self localFileSize];
    
    if (localFileSize==fileSize)
    {
        bn_dispatch_main_async_safe(^{
            completion(self.cacheDirectory);
        });
        return;
    }
    
    //3.没有本地缓存，就到remote下载
    long long from=0;
    long long to=0;
    while (fileSize>kBytesOfOnce)
    {
        to=from+kBytesOfOnce-1;
        [self downloadFileWithUrlString:urlString from:from to:to];
        from+=kBytesOfOnce;
        fileSize-=kBytesOfOnce;
    }
    to+=fileSize;
    [self downloadFileWithUrlString:urlString from:from to:to];
    
    bn_dispatch_main_async_safe(^{
        completion(self.cacheDirectory);
    });
}

- (void)downloadFileWithUrlString:(NSString *)urlString from:(long long)from to:(long long)to
{
    NSMutableURLRequest *mutableRequest=[self mutableRequestWithUrlString:urlString];
    NSString *range=[NSString stringWithFormat:@"bytes=%lld-%lld",from,to];
//    NSLog(@"range:%@",range);
    
    [mutableRequest setValue:range forHTTPHeaderField:@"Range"];
    
    NSURLResponse *response=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:&response error:NULL];
    NSLog(@"response:%@",response);
    
    [self appenData:data];
}

#pragma mark - Local

- (long long)localFileSize
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [[fileManager attributesOfItemAtPath:self.cacheDirectory error:NULL] fileSize];
}

- (void)appenData:(NSData *)data
{
    NSFileHandle *fp=[NSFileHandle fileHandleForWritingAtPath:self.cacheDirectory];
    if(!fp) {
        [data writeToFile:self.cacheDirectory atomically:YES];
    }
    else
    {
        [fp seekToEndOfFile];
        [fp writeData:data];
        [fp closeFile];
    }
}

@end

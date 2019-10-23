//
//  BNUploadPUTTest.m
//  objcReview
//
//  Created by aBerning on 2019/10/10.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNUploadPUTTest.h"

@interface BNUploader : NSObject

- (void)upload:(NSString *)URLString;
@end


@implementation BNUploadPUTTest

#pragma mark - Test Interface
+ (void)test
{
    BNUploader *uploader=[[BNUploader alloc] init];
    NSString *URLString=@"http://localhost/uploads/bird.mp4";
    [uploader upload:URLString];
}


@end


@implementation BNUploader

- (void)upload:(NSString *)URLString
{
    
    NSString *authorString=@"admin:wbn609623.";
    authorString=[[authorString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    authorString=[NSString stringWithFormat:@"Basic %@",authorString];
    NSLog(@"authorString:%@",authorString);
    
    NSURL *url=[NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *mutableRequest=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    [mutableRequest setHTTPMethod:@"PUT"];
    [mutableRequest setValue:authorString forHTTPHeaderField:@"Authorization"];

    NSURL *fileURL=[[NSBundle mainBundle] URLForResource:@"promo.mp4" withExtension:nil];
    NSLog(@"fileURL=========>%@",fileURL);
    
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:mutableRequest fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"response=========>%@",response);
    } ];

    [uploadTask resume];
    
}

@end

//
//  BNFileUploadPOSTTest.m
//  objcReview
//
//  Created by aBerning on 2019/10/7.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNUploadPOSTTest.h"

@interface BNMultipartFormData : NSObject

- (NSURLRequest *)multipartFormWithUrlString:(NSString *)urlString sourceName:(NSString *)sourceName mimeType:(NSString *)mimeType destinationName:(NSString *)destinationName;

@end




@implementation BNUploadPOSTTest

#pragma  mark - Test Interface
+ (void)test
{
    BNUploadPOSTTest *upload=[[self alloc] init];

    NSString *urlString=@"http://121.40.171.11/objc/upload.php";
    NSString *fileString=[[NSBundle mainBundle] pathForResource:@"icon.jpeg" ofType:nil];

    [upload upload:urlString file:fileString];
    
}

- (void)upload:(NSString *)urlString file:(NSString *)fileString
{
    BNMultipartFormData *multipartForm=[[BNMultipartFormData alloc] init];
    NSURLRequest *request=[multipartForm multipartFormWithUrlString:urlString sourceName:fileString mimeType:@"image/jpeg" destinationName:@"berning.jpeg"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"data---%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}
@end


#pragma mark -

#define kUploadName  @"uploadFile"

static NSString * BNCreateMultipartFormBoundary() {
    return [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
}

static NSString * const kBNMultipartFormCRLF = @"\r\n";

static inline NSString * BNMultipartFormInitialBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"--%@%@", boundary, kBNMultipartFormCRLF];
}

static inline NSString * BNMultipartFormEncapsulationBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@%@", kBNMultipartFormCRLF, boundary, kBNMultipartFormCRLF];
}

static inline NSString * BNMultipartFormFinalBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@--%@", kBNMultipartFormCRLF, boundary, kBNMultipartFormCRLF];
}

@interface BNMultipartFormData()

@property(nonatomic,copy)NSString *boundary;

@property(nonatomic,copy)NSString *uploadName;

@end


@implementation BNMultipartFormData

- (NSURLRequest *)multipartFormWithUrlString:(NSString *)urlString sourceName:(NSString *)sourceName mimeType:(NSString *)mimeType destinationName:(NSString *)destinationName
{
    // 1> 数据体
    NSString *topStr = [self initialBoundaryStringWithMimeType:mimeType uploadFile:destinationName];
    NSString *bottomStr = [self encapsulationAndFinalBoundariesString];
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:[NSData dataWithContentsOfFile:sourceName]];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest *mutableRequest=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:0 timeoutInterval:10.0f];
    mutableRequest.HTTPMethod=@"POST";
    mutableRequest.HTTPBody=dataM;
    NSString *stringForContentType=[NSString stringWithFormat:@"multipart/form-data;boundary=%@",self.boundary];
    [mutableRequest setValue:stringForContentType forHTTPHeaderField:@"Content-Type"];
    NSString *stringForContentLength=[NSString stringWithFormat:@"%ld",(long)dataM.length];
    [mutableRequest setValue:stringForContentLength forHTTPHeaderField:@"Content-Length"];

    return [mutableRequest copy];
}

- (instancetype)init
{
    if (self=[super init])
    {
        self.boundary=BNCreateMultipartFormBoundary();
        self.uploadName=kUploadName;
    }
    return self;
}

#pragma mark - 私有方法
- (NSString *)initialBoundaryStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)filename
{
    NSMutableString *strM = [NSMutableString string];

    [strM appendFormat:@"%@",BNMultipartFormInitialBoundary(self.boundary)];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", self.uploadName, filename];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];

    NSLog(@"\n%@", strM);
    return [strM copy];
}

- (NSString *)encapsulationAndFinalBoundariesString
{
    NSMutableString *strM = [NSMutableString string];

    [strM appendFormat:@"%@",BNMultipartFormEncapsulationBoundary(self.boundary)];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@",BNMultipartFormFinalBoundary(self.boundary)];

    NSLog(@"\r%@", strM);
    return [strM copy];
}

@end

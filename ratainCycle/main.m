//
//  main.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)

static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * AFPercentEscapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * AFPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

#pragma mark -

@interface AFQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;
@end


@implementation AFQueryStringPair

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return AFPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding);
    } else {
        return [NSString stringWithFormat:@"%@=%@", AFPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding), AFPercentEscapedQueryStringValueFromStringWithEncoding([self.value description], stringEncoding)];
    }
}

@end


NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = [dictionary objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[AFQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

static NSString * AFQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (AFQueryStringPair *pair in AFQueryStringPairsFromKeyAndValue(nil, parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

void testRequestHeaders()
{
    //User-Agent
    //command line has not UIKit
//    NSString *userAgent=[NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];

    
    //Accept-Language
    NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        float q = 1.0f - (idx * 0.1f);
        [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
        *stop = q <= 0.5f;
    }];
    NSLog(@"locale:%@",[NSLocale preferredLanguages]);
    NSLog(@"accept-language:%@",acceptLanguagesComponents);

}

void testParamsToKeyValues()
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
    
    
    NSLog(@"dict:%@",dic);
    
    NSString *str=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSLog(@"str:%@",str);
    
    NSArray *arr=AFQueryStringPairsFromKeyAndValue(nil, dic);
    NSLog(@"arr:%@",arr);
    
    for (AFQueryStringPair *pair in arr) {
        NSLog(@"pair:%@",[pair description]);
    }
    
    NSLog(@"Str:%@",AFQueryStringFromParametersWithEncoding(dic, NSUTF8StringEncoding));
    
    //    普通打印
    NSArray *arr1=@[@"bbs",@33,@{@"wbn":@"men"}];
    NSLog(@"arr1:%@",arr1);
    
    //数组内对象打印
    NSMutableArray *arr2=[NSMutableArray array];
    NSObject *obj1=[NSObject new];
    NSObject *obj2=[NSObject new];
    NSObject *obj3=[NSObject new];
    [arr2 addObject:obj1];
    [arr2 addObject:obj2];
    [arr2 addObject:obj3];
    NSLog(@"arr2:%@",arr2);

}

void testBaseARC()
{
//    testParamsToKeyValues();
//    testRequestHeaders();
}

#else
#import "bnManager.h"

void testBaseMRC()
{
    bnManager *mgr=[bnManager new];
    [mgr test];
    
    [mgr release];
    
}

#endif


int main(int argc, const char * argv[]) {
    @autoreleasepool {
#if !__has_feature(objc_arc)
        
        testBaseMRC();
        
#else

        testBaseARC();
        
        
#endif

    }
    return 0;
}

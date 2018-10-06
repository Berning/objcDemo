//
//  BNRunTime.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//
//clang -rewrite-objc xxx.m

#import <Foundation/Foundation.h>

@interface BNRunTime : NSObject

+(void)runTimeExecute;

//方法交换
+(void)methodSwizzling;

//添加属性
+(void)addProperty;

//get
+(void)enumarateClassIvars;
+(void)enumarateClassProperties;
+(void)enumarateClassMethods;
//apply
+(void)keyValuesTest;

//消息转发
+(void)methodForwardingTest;

@end
